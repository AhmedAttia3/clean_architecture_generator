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
        final methodName =
            names.firstUpper(method.name).replaceFirst('Get', '');
        final useCaseName = '${methodName}UseCase';
        final type = methodFormat.returnType(method.type);
        final responseDataType = names.responseDataType(type);

        ///[cache]
        final cacheUseCase = StringBuffer();

        ///[Imports]
        cacheUseCase.writeln(Imports.create(
          imports: [repositoryName],
          filePath: buildStep.inputId.path,
          isUseCase: noParams,
          hasCache: true,
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
        cacheUseCase.writeln('if(request != null){');
        cacheUseCase.writeln('return await repository.cache$methodName');
        cacheUseCase.writeln('(data: request);');
        cacheUseCase.writeln('}');
        cacheUseCase.writeln('return const Right(unit);');
        cacheUseCase.writeln('}\n');
        cacheUseCase.writeln('}\n');
        useCase.writeln(cacheUseCase);
        AddFile.save('$path/Cache$useCaseName', cacheUseCase.toString());

        ///[get]
        final getCacheUseCase = StringBuffer();

        ///[Imports]
        getCacheUseCase.writeln(Imports.create(
          imports: [repositoryName],
          filePath: buildStep.inputId.path,
          isUseCase: true,
        ));
        getCacheUseCase.writeln('///[GetCache$useCaseName]');
        getCacheUseCase.writeln('///[Implementation]');
        getCacheUseCase.writeln('@injectable');
        getCacheUseCase.writeln(
            'class GetCache$useCaseName implements BaseUseCase<Either<Failure, $responseDataType>, Void?>{');
        getCacheUseCase.writeln('final $repositoryName repository;');
        getCacheUseCase.writeln('const GetCache$useCaseName(');
        getCacheUseCase.writeln('this.repository,');
        getCacheUseCase.writeln(');\n');
        getCacheUseCase.writeln('@override');
        getCacheUseCase.writeln(
            'Either<Failure, $responseDataType> execute({Void? request,}) {');
        getCacheUseCase.writeln('return repository.getCache$methodName();');
        getCacheUseCase.writeln('}\n');
        getCacheUseCase.writeln('}\n');
        useCase.writeln(getCacheUseCase);
        AddFile.save('$path/GetCache$useCaseName', getCacheUseCase.toString());
        classBuffer.write(useCase);
      }
    }
    return classBuffer.toString();
  }
}
