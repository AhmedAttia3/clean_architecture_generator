import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/clean_architecture_generator.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/imports_file.dart';
import 'package:source_gen/source_gen.dart';

import '../file_manager.dart';
import '../model_visitor.dart';

class RemoteDataSourceGenerator
    extends GeneratorForAnnotation<ArchitectureAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final visitor = ModelVisitor();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);
    final basePath = FileManager.getDirectories(buildStep.inputId.path);
    final path = "$basePath/data/data-sources";

    final names = Names();
    final remoteDataSource = StringBuffer();
    final clientServiceType = visitor.clientService;
    final clientServiceName = names.firstLower(clientServiceType);
    final remoteDataSourceType = visitor.remoteDataSource;
    final remoteDataSourceTypeImpl =
        names.repositoryImplType(remoteDataSourceType);

    List<String> imports = [];
    for (var method in visitor.useCases) {
      final returnType = methodFormat.returnType(method.type);
      final type = methodFormat.responseType(returnType);
      if (method.requestType == RequestType.Body) {
        final request = names.requestType(method.name);
        imports.add(request);
      }
      imports.add(type);
    }

    ///[Imports]
    remoteDataSource.writeln(
      Imports.create(
        imports: imports,
      ),
    );

    remoteDataSource.writeln('///[Implementation]');
    remoteDataSource.writeln('abstract class $remoteDataSourceType {');
    bool hasCache = false;
    for (var method in visitor.useCases) {
      final methodName = names.firstLower(method.name);
      final type = methodFormat.returnType(method.type);
      if (method.requestType == RequestType.Fields || !method.hasRequest) {
        remoteDataSource.writeln(
            'Future<Either<Failure, $type>> $methodName(${methodFormat.parameters(method.parameters)});');
      } else {
        final request = names.requestType(method.name);
        remoteDataSource.writeln(
            'Future<Either<Failure, $type>> $methodName({required $request request});');
      }
    }
    remoteDataSource.writeln('}\n');

    FileManager.save(
      '$path/$remoteDataSourceType',
      remoteDataSource.toString(),
      allowUpdates: true,
    );

    final remoteDataSourceImpl = StringBuffer();

    ///[Imports]
    remoteDataSourceImpl.writeln(Imports.create(
      imports: [
        clientServiceType,
        ...imports,
        'base_response',
      ],
      hasCache: hasCache,
      isRepo: true,
    ));
    remoteDataSourceImpl.writeln('///[$remoteDataSourceType]');
    remoteDataSourceImpl.writeln('///[Implementation]');
    remoteDataSourceImpl.writeln('@Injectable(as:$remoteDataSourceType)');
    remoteDataSourceImpl.writeln(
        'class $remoteDataSourceTypeImpl implements $remoteDataSourceType {');
    remoteDataSourceImpl
        .writeln('final $clientServiceType $clientServiceName;');

    remoteDataSourceImpl.writeln('final SafeApi api;');
    remoteDataSourceImpl.writeln('const $remoteDataSourceTypeImpl(');
    remoteDataSourceImpl.writeln('this.$clientServiceName,');
    remoteDataSourceImpl.writeln('this.api,');
    remoteDataSourceImpl.writeln(');\n');

    for (var method in visitor.useCases) {
      final methodName = names.firstLower(method.name);
      final type = methodFormat.returnType(method.type);
      remoteDataSourceImpl.writeln('@override');
      if (method.requestType == RequestType.Fields || !method.hasRequest) {
        remoteDataSourceImpl.writeln(
            'Future<Either<Failure, $type>> $methodName(${methodFormat.parameters(method.parameters)})async {');
        remoteDataSourceImpl.writeln('return await api<$type>(');

        remoteDataSourceImpl.writeln(
            'apiCall: $clientServiceName.${method.name}(${methodFormat.passingParameters(method.parameters)}),);');
        remoteDataSourceImpl.writeln('}\n');
      } else {
        final request = names.requestType(method.name);
        remoteDataSourceImpl.writeln(
            'Future<Either<Failure, $type>> $methodName({required $request request,})async {');
        remoteDataSourceImpl.writeln('return await api<$type>(');

        remoteDataSourceImpl
            .writeln('apiCall: $clientServiceName.${method.name}(');
        for (var param in method.requestParameters) {
          if (param.type == ParamType.Path || param.type == ParamType.Path) {
            remoteDataSourceImpl
                .writeln('${param.name}:request.${param.name},');
          }
        }
        remoteDataSourceImpl.writeln('request: request,),);');
        remoteDataSourceImpl.writeln('}\n');
      }
    }
    remoteDataSourceImpl.writeln('}\n');

    FileManager.save(
      '$path/${remoteDataSourceType}Impl',
      remoteDataSourceImpl.toString(),
      allowUpdates: true,
    );

    return "";
  }
}
