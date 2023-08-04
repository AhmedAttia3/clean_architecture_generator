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
    final abstractRepoPath =
        "${AddFile.getDirectories(buildStep.inputId.path)}/domain/repository";
    final implRepoPath =
        "${AddFile.getDirectories(buildStep.inputId.path)}/data/repository";
    final visitor = ModelVisitor();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);

    final repository = StringBuffer();
    final clientService = names.firstLower(visitor.className);

    final repositoryName = '${names.firstUpper(visitor.className)}Repository';
    final repositoryNameImplement = '${repositoryName}Implement';

    ///[Imports]
    repository.writeln(Imports.create(
      filePath: buildStep.inputId.path,
    ));
    repository.writeln('///[Implementation]');
    repository.writeln('abstract class $repositoryName {');
    bool hasCache = false;
    for (var method in visitor.useCases) {
      final useCaseName = names.firstLower(method.name);
      final type = methodFormat.returnType(method.type);
      final responseDataType = names.responseDataType(type);
      repository.writeln(
          'Future<Either<Failure, $type>> $useCaseName(${methodFormat.parameters(method.parameters)});');

      ///[cache save or get]
      if (method.isCache) {
        hasCache = true;
        final useCaseName =
            names.firstUpper(method.name).replaceFirst('Get', '');
        repository.writeln(
            'Future<Either<Failure, Unit>> cache$useCaseName({required $responseDataType data,});');
        repository.writeln(
            'Either<Failure, $responseDataType> getCache$useCaseName();');
      }
    }
    repository.writeln('}\n');

    AddFile.save(
      '$abstractRepoPath/$repositoryName',
      repository.toString(),
      allowUpdates: true,
    );

    final repositoryImpl = StringBuffer();
    final localDataSourceType = names.localDataSourceType(visitor.className);
    final localDataSourceName = names.firstLower(localDataSourceType);

    ///[Imports]
    repositoryImpl.writeln(Imports.create(
      imports: [repositoryName, clientService, localDataSourceType],
      hasCache: hasCache,
      filePath: buildStep.inputId.path,
      isRepo: true,
    ));
    repositoryImpl.writeln('///[$repositoryNameImplement]');
    repositoryImpl.writeln('///[Implementation]');
    repositoryImpl.writeln('@Injectable(as:$repositoryName)');
    repositoryImpl
        .writeln('class $repositoryNameImplement implements $repositoryName {');
    repositoryImpl.writeln('final ${visitor.className} $clientService;');

    ///[add cache]
    if (hasCache) {
      repositoryImpl
          .writeln('final $localDataSourceType $localDataSourceName;');
    }

    repositoryImpl.writeln('final SafeApi api;');
    repositoryImpl.writeln('const $repositoryNameImplement(');
    repositoryImpl.writeln('this.$clientService,');

    ///[add cache]
    if (hasCache) {
      repositoryImpl.writeln('this.$localDataSourceName,');
    }
    repositoryImpl.writeln('this.api,');
    repositoryImpl.writeln(');\n');

    for (var method in visitor.useCases) {
      final useCaseName = names.firstLower(method.name);
      final type = methodFormat.returnType(method.type);
      final responseDataType = names.responseDataType(type);
      final modelName = names.baseModelName(type);
      repositoryImpl.writeln('@override');
      repositoryImpl.writeln(
          'Future<Either<Failure, $type>> $useCaseName(${methodFormat.parameters(method.parameters)})async {');
      repositoryImpl.writeln('return await api<$type>(');

      repositoryImpl.writeln(
          'apiCall: $clientService.${method.name}(${methodFormat.passingParameters(method.parameters)}),);');
      repositoryImpl.writeln('}\n');

      ///[cache save or get implement]
      if (method.isCache) {
        final useCaseName =
            names.firstUpper(method.name).replaceFirst('Get', '');

        ///[cache]
        repositoryImpl.writeln('@override');
        repositoryImpl.writeln(
            'Future<Either<Failure, Unit>> cache$useCaseName({required $responseDataType data,}) async {');
        repositoryImpl.writeln(
            'return await $localDataSourceName.cache$useCaseName(data: data);');
        repositoryImpl.writeln('}\n');

        ///[get]
        repositoryImpl.writeln('@override');
        repositoryImpl.writeln(
            'Either<Failure, $responseDataType> getCache$useCaseName(){');
        repositoryImpl
            .writeln('return $localDataSourceName.getCache$useCaseName();');
        repositoryImpl.writeln('}\n');
      }
    }
    repositoryImpl.writeln('}\n');
    AddFile.save(
      '$implRepoPath/${repositoryName}Impl',
      repositoryImpl.toString(),
      allowUpdates: true,
    );
    repository.writeln(repositoryImpl);
    return repository.toString();
  }
}
