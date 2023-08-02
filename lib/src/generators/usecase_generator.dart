import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:mvvm_generator/formatter/method_format.dart';
import 'package:mvvm_generator/formatter/names.dart';
import 'package:mvvm_generator/mvvm_generator.dart';
import 'package:mvvm_generator/src/add_file_to_project.dart';
import 'package:mvvm_generator/src/model_visitor.dart';
import 'package:source_gen/source_gen.dart';

import '../read_imports_file.dart';

class UseCaseGenerator extends GeneratorForAnnotation<MVVMAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final basePath = AddFile.path(buildStep.inputId.path);
    final path = "$basePath/use-cases";
    final visitor = ModelVisitor();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);

    final repositoryName = '${names.firstUpper(visitor.className)}Repository';

    ///[BaseUseCase]
    final baseUseCase = StringBuffer();
    baseUseCase.writeln('///[BaseUseCase]');
    baseUseCase.writeln('///${paths.join('/')}');
    baseUseCase.writeln('///[Implementation]');
    baseUseCase.writeln("import 'package:eitherx/eitherx.dart';");
    baseUseCase.writeln("abstract class BaseUseCase<RES, POS> {");
    baseUseCase.writeln("RES execute({POS? request});");
    baseUseCase.writeln("}");

    AddFile.save('/lib/core/base_use_case', baseUseCase.toString());

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
      if (noParams) useCase.writeln("import 'dart:ffi';");
      useCase.writeln(ReadImports.imports(
        repositoryName: repositoryName,
        requestName: noParams ? "" : requestName,
        filePath: buildStep.inputId.path,
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
            'Future<Either<Failure, $type>> execute({Void? request}) async {');
      } else {
        useCase.writeln('@override');
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
