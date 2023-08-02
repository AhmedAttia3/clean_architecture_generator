import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:mvvm_generator/formatter/method_format.dart';
import 'package:mvvm_generator/formatter/names.dart';
import 'package:mvvm_generator/mvvm_generator.dart';
import 'package:mvvm_generator/src/add_file_to_project.dart';
import 'package:mvvm_generator/src/model_visitor.dart';
import 'package:source_gen/source_gen.dart';

import '../read_imports_file.dart';

class CacheUseCaseGenerator extends GeneratorForAnnotation<MVVMAnnotation> {
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

    ///[UseCase]
    final classBuffer = StringBuffer();
    for (var method in visitor.useCases) {
      final isCached = method.comment?.contains('///cache');

      ///[cache save or get implement useCases]
      if (isCached == true) {
        final useCase = StringBuffer();
        final noParams = method.parameters.isEmpty;
        final useCaseName = '${names.firstUpper(method.name)}UseCase';
        final type = methodFormat.returnType(method.type);
        final responseDataType = names.responseDataType(type);
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
            'class Cache$useCaseName implements BaseUseCase<Future<Either<Failure, Unit>>,$responseDataType> {');
        cacheUseCase.writeln('final $repositoryName repository;');
        cacheUseCase.writeln('const Cache$useCaseName(');
        cacheUseCase.writeln('this.repository,');
        cacheUseCase.writeln(');\n');
        cacheUseCase.writeln('@override');
        cacheUseCase.writeln(
            'Future<Either<Failure, Unit>> execute({$responseDataType? request,}) async {');
        cacheUseCase.writeln('if(request!=null){');
        cacheUseCase.writeln('return await repository.cache$methodName');
        cacheUseCase.writeln('(data: request!);');
        cacheUseCase.writeln('}');
        cacheUseCase.writeln('return const Right(unit);');
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
            'class Get$useCaseName implements BaseUseCase<Either<Failure, $responseDataType>, Void?>{');
        getCacheUseCase.writeln('final $repositoryName repository;');
        getCacheUseCase.writeln('const Get$useCaseName(');
        getCacheUseCase.writeln('this.repository,');
        getCacheUseCase.writeln(');\n');
        getCacheUseCase.writeln(
            'Either<Failure, $responseDataType> execute({Void? request}) {');
        getCacheUseCase.writeln('return repository.get$methodName();');
        getCacheUseCase.writeln('}\n');
        getCacheUseCase.writeln('}\n');
        useCase.writeln(getCacheUseCase);
        AddFile.save('$path/Get$useCaseName', getCacheUseCase.toString());
        classBuffer.write(useCase);
      }
    }
    return classBuffer.toString();
  }
}
