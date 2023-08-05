import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/annotations.dart';
import 'package:source_gen/source_gen.dart';

import '../add_file_to_project.dart';
import '../model_visitor.dart';
import '../read_imports_file.dart';

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
    final path = AddFile.getDirectories(buildStep.inputId.path);
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

    ///[Imports]
    repository.writeln(Imports.create(
      filePath: buildStep.inputId.path,
    ));
    repository.writeln('///[Implementation]');
    repository.writeln('abstract class $repositoryType {');
    bool hasCache = false;
    for (var method in visitor.useCases) {
      final methodName = names.firstLower(method.name);
      final type = methodFormat.returnType(method.type);
      final responseType = names.responseType(type);
      repository.writeln(
          'Future<Either<Failure, $type>> $methodName(${methodFormat.parameters(method.parameters)});');

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

    AddFile.save(
      '$abstractRepoPath/$repositoryType',
      repository.toString(),
      allowUpdates: true,
    );

    final repositoryImpl = StringBuffer();

    ///[Imports]
    repositoryImpl.writeln(Imports.create(
      imports: [repositoryType, clientService, localDataSourceType],
      hasCache: hasCache,
      filePath: buildStep.inputId.path,
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
      final responseType = names.responseType(type);
      repositoryImpl.writeln('@override');
      repositoryImpl.writeln(
          'Future<Either<Failure, $type>> $methodName(${methodFormat.parameters(method.parameters)})async {');
      repositoryImpl.writeln('return await api<$type>(');

      repositoryImpl.writeln(
          'apiCall: $clientService.${method.name}(${methodFormat.passingParameters(method.parameters)}),);');
      repositoryImpl.writeln('}\n');

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
    AddFile.save(
      '$implRepoPath/${repositoryType}Impl',
      repositoryImpl.toString(),
      allowUpdates: true,
    );
    repository.writeln(repositoryImpl);
    return repository.toString();
  }
}
