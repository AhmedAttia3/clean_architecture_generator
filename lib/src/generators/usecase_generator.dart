import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/clean_architecture_generator.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/model_visitor.dart';
import 'package:source_gen/source_gen.dart';

import '../imports_file.dart';

class UseCaseGenerator extends GeneratorForAnnotation<ArchitectureAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final basePath = AddFile.getDirectories(buildStep.inputId.path);
    final path = "$basePath/domain/use-cases";
    final visitor = ModelVisitor();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);

    final repositoryType = names.repositoryType(visitor.className);

    List<String> imports = [];
    for (var method in visitor.useCases) {
      final returnType = methodFormat.returnType(method.type);
      final type = methodFormat.responseType(returnType);
      imports.add(type);
    }

    ///[UseCase]
    final classBuffer = StringBuffer();
    for (var method in visitor.useCases) {
      final useCase = StringBuffer();
      final noParams = !method.hasRequest;
      final useCaseType = names.useCaseType(method.name);
      final requestType = noParams
          ? method.parameters.isNotEmpty
              ? "${method.parameters.first.type}"
              : 'Void'
          : names.requestType(method.name);
      final methodName = names.firstLower(method.name);
      final type = methodFormat.returnType(method.type);
      useCase.writeln('///[Implementation]');

      ///[Imports]
      useCase.writeln(Imports.create(
        imports: [
          repositoryType,
          noParams ? "" : requestType,
          ...imports,
        ],
        isUseCase: noParams,
      ));
      useCase.writeln('///[$useCaseType]');
      useCase.writeln('///[Implementation]');
      useCase.writeln('@injectable');
      useCase.writeln(
          'class $useCaseType implements BaseUseCase<Future<Either<Failure, $type>>,$requestType>{');
      useCase.writeln('final $repositoryType repository;');
      useCase.writeln('const $useCaseType(');
      useCase.writeln('this.repository,');
      useCase.writeln(');\n');
      useCase.writeln('@override');
      useCase.writeln(
          'Future<Either<Failure, $type>> execute({$requestType? request,}) async {');
      useCase.writeln('return await repository.$methodName');
      if (method.requestType == RequestType.Body && method.hasRequest) {
        useCase
            .writeln('(${methodFormat.requestParameters(method.parameters)});');
      } else if (method.parameters.isNotEmpty) {
        useCase.writeln('(${method.parameters.first.name} : request!);');
      } else {
        useCase.writeln('();');
      }
      useCase.writeln('}\n');
      useCase.writeln('}\n');

      AddFile.save('$path/$useCaseType', useCase.toString());
      classBuffer.write(useCase);
    }
    return classBuffer.toString();
  }
}
