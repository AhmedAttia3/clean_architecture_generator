import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/clean_architecture_generator.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/model_visitor.dart';
import 'package:source_gen/source_gen.dart';

import '../read_imports_file.dart';

class CacheUseCaseGenerator
    extends GeneratorForAnnotation<ArchitectureAnnotation> {
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

    final repositoryName = '${names.firstUpper(visitor.className)}Repository';

    ///[UseCase]
    final classBuffer = StringBuffer();
    for (var method in visitor.useCases) {
      ///[cache save or get implement useCases]
      if (method.isCache) {
        final useCase = StringBuffer();
        final noParams = method.parameters.isEmpty;
        final cacheMethodName = names.cacheName(method.name);
        final getCacheMethodName = names.getCacheName(method.name);
        final cacheUseCaseType =
            names.useCaseType(names.cacheType(method.name));
        final getCacheUseCaseType =
            names.useCaseType(names.getCacheType(method.name));
        final type = methodFormat.returnType(method.type);
        final responseType = names.responseType(type);

        ///[cache]
        final cacheUseCase = StringBuffer();

        ///[Imports]
        cacheUseCase.writeln(Imports.create(
          imports: [repositoryName],
          filePath: buildStep.inputId.path,
          isUseCase: noParams,
          hasCache: true,
        ));
        cacheUseCase.writeln('///[$cacheUseCaseType]');
        cacheUseCase.writeln('///[Implementation]');
        cacheUseCase.writeln('@injectable');
        cacheUseCase.writeln(
            'class $cacheUseCaseType implements BaseUseCase<Future<Either<Failure, Unit>>,$responseType> {');
        cacheUseCase.writeln('final $repositoryName repository;');
        cacheUseCase.writeln('const $cacheUseCaseType(');
        cacheUseCase.writeln('this.repository,');
        cacheUseCase.writeln(');\n');
        cacheUseCase.writeln('@override');
        cacheUseCase.writeln(
            'Future<Either<Failure, Unit>> execute({$responseType? request,}) async {');
        cacheUseCase.writeln('if(request != null){');
        cacheUseCase.writeln('return await repository.$cacheMethodName');
        cacheUseCase.writeln('(data: request);');
        cacheUseCase.writeln('}');
        cacheUseCase.writeln('return const Right(unit);');
        cacheUseCase.writeln('}\n');
        cacheUseCase.writeln('}\n');
        useCase.writeln(cacheUseCase);
        AddFile.save('$path/$cacheUseCaseType', cacheUseCase.toString());

        ///[get]
        final getCacheUseCase = StringBuffer();

        ///[Imports]
        getCacheUseCase.writeln(Imports.create(
          imports: [
            repositoryName,
            getCacheUseCaseType,
          ],
          filePath: buildStep.inputId.path,
          isUseCase: true,
        ));
        getCacheUseCase.writeln('///[$getCacheUseCaseType]');
        getCacheUseCase.writeln('///[Implementation]');
        getCacheUseCase.writeln('@injectable');
        getCacheUseCase.writeln(
            'class $getCacheUseCaseType implements BaseUseCase<Either<Failure, $responseType>, Void?>{');
        getCacheUseCase.writeln('final $repositoryName repository;');
        getCacheUseCase.writeln('const $getCacheUseCaseType(');
        getCacheUseCase.writeln('this.repository,');
        getCacheUseCase.writeln(');\n');
        getCacheUseCase.writeln('@override');
        getCacheUseCase.writeln(
            'Either<Failure, $responseType> execute({Void? request,}) {');
        getCacheUseCase.writeln('return repository.$getCacheMethodName();');
        getCacheUseCase.writeln('}\n');
        getCacheUseCase.writeln('}\n');
        useCase.writeln(getCacheUseCase);
        AddFile.save('$path/$getCacheMethodName', getCacheUseCase.toString());
        classBuffer.write(useCase);
      }
    }
    return classBuffer.toString();
  }
}
