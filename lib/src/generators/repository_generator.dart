import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/annotations.dart';
import 'package:clean_architecture_generator/src/models/clean_method.dart';
import 'package:source_gen/source_gen.dart';

import '../file_manager.dart';
import '../imports_file.dart';
import '../model_visitor.dart';

class RepositoryGenerator
    extends GeneratorForAnnotation<ArchitectureAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final visitor = ModelVisitor();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);
    final path = FileManager.getDirectories(buildStep.inputId.path);
    final abstractRepoPath = "$path/domain/repository";
    final implRepoPath = "$path/data/repository";

    final repository = StringBuffer();
    final clientService = names.firstLower(visitor.className);

    final localDataSourceType = names.localDataSourceType(visitor.className);
    final localDataSourceName = names.localDataSourceName(visitor.className);
    final remoteDataSourceType = names.firstUpper(visitor.className);
    final repositoryType = names.repositoryType(remoteDataSourceType);
    final repositoryImplementType =
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
    repository.writeln(
      Imports.create(
        imports: imports,
      ),
    );

    repository.writeln('///[Implementation]');
    repository.writeln('abstract class $repositoryType {');
    bool hasCache = false;
    for (var method in visitor.useCases) {
      final methodName = names.firstLower(method.name);
      final type = methodFormat.returnType(method.type);
      final responseType = methodFormat.responseType(type);
      if (method.requestType == RequestType.Fields || !method.hasRequest) {
        repository.writeln(
            'Future<Either<Failure, $type>> $methodName(${methodFormat.parameters(method.parameters)});');
      } else {
        final request = names.requestType(method.name);
        repository.writeln(
            'Future<Either<Failure, $type>> $methodName({required $request request});');
      }

      ///[cache save or get]
      if (method.isCache) {
        hasCache = true;
        final getCacheMethodName = names.getCacheName(methodName);
        final cacheMethodName = names.cacheName(methodName);
        repository.writeln(
            'Future<Either<Failure, Unit>> $cacheMethodName({required $responseType data,});');
        repository
            .writeln('Either<Failure, $responseType> $getCacheMethodName();');
      }
    }
    repository.writeln('}\n');

    FileManager.save(
      '$abstractRepoPath/$repositoryType',
      repository.toString(),
      allowUpdates: true,
    );

    final repositoryImpl = StringBuffer();

    ///[Imports]
    repositoryImpl.writeln(Imports.create(
      imports: [
        repositoryType,
        clientService,
        localDataSourceType,
        ...imports,
        'base_response'
      ],
      hasCache: hasCache,
      isRepo: true,
    ));
    repositoryImpl.writeln('///[$repositoryImplementType]');
    repositoryImpl.writeln('///[Implementation]');
    repositoryImpl.writeln('@Injectable(as:$repositoryType)');
    repositoryImpl
        .writeln('class $repositoryImplementType implements $repositoryType {');
    repositoryImpl.writeln('final ${visitor.className} $clientService;');

    ///[add cache]
    if (hasCache) {
      repositoryImpl
          .writeln('final $localDataSourceType $localDataSourceName;');
    }

    repositoryImpl.writeln('final SafeApi api;');
    repositoryImpl.writeln('const $repositoryImplementType(');
    repositoryImpl.writeln('this.$clientService,');

    ///[add cache]
    if (hasCache) {
      repositoryImpl.writeln('this.$localDataSourceName,');
    }
    repositoryImpl.writeln('this.api,');
    repositoryImpl.writeln(');\n');

    for (var method in visitor.useCases) {
      final methodName = names.firstLower(method.name);
      final type = methodFormat.returnType(method.type);
      final responseType = methodFormat.responseType(type);
      repositoryImpl.writeln('@override');
      if (method.requestType == RequestType.Fields || !method.hasRequest) {
        repositoryImpl.writeln(
            'Future<Either<Failure, $type>> $methodName(${methodFormat.parameters(method.parameters)})async {');
        repositoryImpl.writeln('return await api<$type>(');

        repositoryImpl.writeln(
            'apiCall: $clientService.${method.name}(${methodFormat.passingParameters(method.parameters)}),);');
        repositoryImpl.writeln('}\n');
      } else {
        final request = names.requestType(method.name);
        repositoryImpl.writeln(
            'Future<Either<Failure, $type>> $methodName({required $request request,})async {');
        repositoryImpl.writeln('return await api<$type>(');

        repositoryImpl.writeln('apiCall: $clientService.${method.name}(');
        for (var param in method.requestParameters) {
          if (param.type == ParamType.Path || param.type == ParamType.Path) {
            repositoryImpl.writeln('${param.name}:request.${param.name},');
          }
        }
        repositoryImpl.writeln('request: request,),);');
        repositoryImpl.writeln('}\n');
      }

      ///[cache save or get implement]
      if (method.isCache) {
        final cacheMethodName = names.cacheName(method.name);
        final getCacheMethodName = names.getCacheName(method.name);

        ///[cache]
        repositoryImpl.writeln('@override');
        repositoryImpl.writeln(
            'Future<Either<Failure, Unit>> $cacheMethodName({required $responseType data,}) async {');
        repositoryImpl.writeln(
            'return await $localDataSourceName.$cacheMethodName(data: data);');
        repositoryImpl.writeln('}\n');

        ///[get]
        repositoryImpl.writeln('@override');
        repositoryImpl
            .writeln('Either<Failure, $responseType> $getCacheMethodName(){');
        repositoryImpl
            .writeln('return $localDataSourceName.$getCacheMethodName();');
        repositoryImpl.writeln('}\n');
      }
    }
    repositoryImpl.writeln('}\n');
    FileManager.save(
      '$implRepoPath/${repositoryType}Impl',
      repositoryImpl.toString(),
      allowUpdates: true,
    );
    repository.writeln(repositoryImpl);
    return repository.toString();
  }
}
