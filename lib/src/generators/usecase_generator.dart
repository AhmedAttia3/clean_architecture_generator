import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:generators/formatter/method_format.dart';
import 'package:generators/formatter/names.dart';
import 'package:generators/generators.dart';
import 'package:generators/src/add_file_to_project.dart';
import 'package:generators/src/model_visitor.dart';
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
        useCase.writeln(
            'Future<Either<Failure, $type>> execute({required $requestName request,}) async {');
      }
      useCase.writeln('return await repository.$methodName');
      useCase
          .writeln('(${methodFormat.requestParameters(method.parameters)});');
      useCase.writeln('}\n');
      useCase.writeln('}\n');

      AddFile.save('$path/$useCaseName', useCase.toString());

      ///[cache save or get implement useCases]
      if (method.comment?.contains('///cache') == true) {
        final methodName = names.firstUpper(method.name);

        ///[cache]
        final cacheUseCase = StringBuffer();
        if (noParams) cacheUseCase.writeln("import 'dart:ffi';");
        cacheUseCase.writeln(ReadImports.imports(
          repositoryName: repositoryName,
          filePath: buildStep.inputId.path,
        ));
        cacheUseCase.writeln('///[Cache$useCaseName]');
        cacheUseCase.writeln('///[Implementation]');
        cacheUseCase.writeln('@injectable');
        cacheUseCase.writeln(
            'class Cache$useCaseName implements BaseUseCase<Future<Either<Failure, Unit>>,$type> {');
        cacheUseCase.writeln('final $repositoryName repository;');
        cacheUseCase.writeln('const Cache$useCaseName(');
        cacheUseCase.writeln('this.repository,');
        cacheUseCase.writeln(');\n');
        cacheUseCase.writeln('@override');
        cacheUseCase.writeln(
            'Future<Either<Failure, Unit>> execute({required $type data,}) async {');
        cacheUseCase.writeln('return await repository.cache$methodName');
        cacheUseCase.writeln('(data: this.data);');
        cacheUseCase.writeln('}\n');
        cacheUseCase.writeln('}\n');
        useCase.writeln(cacheUseCase);
        AddFile.save('$path/Cache$useCaseName', cacheUseCase.toString());

        ///[get]
        final getCacheUseCase = StringBuffer();
        getCacheUseCase.writeln("import 'dart:ffi';");
        getCacheUseCase.writeln(ReadImports.imports(
          repositoryName: repositoryName,
          filePath: buildStep.inputId.path,
        ));
        getCacheUseCase.writeln('///[Get$useCaseName]');
        getCacheUseCase.writeln('///[Implementation]');
        getCacheUseCase.writeln('@injectable');
        getCacheUseCase.writeln(
            'class Get$useCaseName implements BaseUseCase<Either<Failure, $type>, Void>{');
        getCacheUseCase.writeln('final $repositoryName repository;');
        getCacheUseCase.writeln('const Get$useCaseName(');
        getCacheUseCase.writeln('this.repository,');
        getCacheUseCase.writeln(');\n');
        getCacheUseCase
            .writeln('Either<Failure, $type> execute({Void? request}) {');
        getCacheUseCase.writeln('return repository.get$methodName();');
        getCacheUseCase.writeln('}\n');
        getCacheUseCase.writeln('}\n');
        useCase.writeln(getCacheUseCase);
        AddFile.save('$path/Get$useCaseName', getCacheUseCase.toString());
      }

      classBuffer.write(useCase);
    }
    return classBuffer.toString();
  }
}
