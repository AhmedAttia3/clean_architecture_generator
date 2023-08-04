import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/clean_architecture_generator.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/model_visitor.dart';
import 'package:source_gen/source_gen.dart';

import '../read_imports_file.dart';

class UseCaseGenerator extends GeneratorForAnnotation<ArchitectureAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final basePath = AddFile.path(buildStep.inputId.path);
    final path = "$basePath/domain/use-cases";
    final visitor = ModelVisitor();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);

    final repositoryName = '${names.firstUpper(visitor.className)}Repository';

    ///[UseCase]
    final classBuffer = StringBuffer();
    for (var method in visitor.useCases) {
      final useCase = StringBuffer();
      final noParams = method.parameters.isEmpty;
      final useCaseName = '${names.firstUpper(method.name)}UseCase';
      final requestName =
          noParams ? 'Void' : '${names.firstUpper(method.name)}Request';
      final methodName = names.firstLower(method.name);
      final type = methodFormat.returnType(method.type);
      useCase.writeln('///[Implementation]');

      ///[Imports]
      useCase.writeln(Imports.create(
        imports: [repositoryName, noParams ? "" : requestName],
        filePath: buildStep.inputId.path,
        isUseCase: noParams,
      ));
      useCase.writeln('///[$useCaseName]');
      useCase.writeln('///[Implementation]');
      useCase.writeln('@injectable');
      useCase.writeln(
          'class $useCaseName implements BaseUseCase<Future<Either<Failure, $type>>,$requestName>{');
      useCase.writeln('final $repositoryName repository;');
      useCase.writeln('const $useCaseName(');
      useCase.writeln('this.repository,');
      useCase.writeln(');\n');
      useCase.writeln('@override');
      if (noParams) {
        useCase.writeln(
            'Future<Either<Failure, $type>> execute({Void? request,}) async {');
      } else {
        useCase.writeln(
            'Future<Either<Failure, $type>> execute({$requestName? request,}) async {');
      }
      useCase.writeln('return await repository.$methodName');
      useCase
          .writeln('(${methodFormat.requestParameters(method.parameters)});');
      useCase.writeln('}\n');
      useCase.writeln('}\n');

      AddFile.save('$path/$useCaseName', useCase.toString());
      classBuffer.write(useCase);
    }
    return classBuffer.toString();
  }
}
