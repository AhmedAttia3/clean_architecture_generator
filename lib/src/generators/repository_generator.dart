import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:mvvm_generator/formatter/method_format.dart';
import 'package:mvvm_generator/formatter/names.dart';
import 'package:mvvm_generator/src/mvvm_generator_annotations.dart';
import 'package:source_gen/source_gen.dart';

import '../add_file_to_project.dart';
import '../model_visitor.dart';
import '../read_imports_file.dart';

class RepositoryGenerator extends GeneratorForAnnotation<MVVMAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final path = "${AddFile.path(buildStep.inputId.path)}/repository";
    final visitor = ModelVisitor();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);

    final repository = StringBuffer();
    final clientService = names.firstLower(visitor.className);

    final repositoryName = '${names.firstUpper(visitor.className)}Repository';
    final repositoryNameImplement = '${repositoryName}Implement';

    repository.writeln(ReadImports.imports(
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
      if (method.comment?.contains('///cache') == true) {
        hasCache = true;
        final useCaseName = names.firstUpper(method.name);
        repository.writeln(
            'Future<Either<Failure, Unit>> cache$useCaseName({required $responseDataType data,});');
        repository
            .writeln('Either<Failure, $responseDataType> get$useCaseName();');
      }
    }
    repository.writeln('}\n');

    AddFile.save('$path/$repositoryName', repository.toString());
    final repositoryImpl = StringBuffer();
    repositoryImpl.writeln(ReadImports.imports(
      imports: [repositoryName, visitor.className],
      hasCache: hasCache,
      filePath: buildStep.inputId.path,
    ));
    repositoryImpl.writeln('///[$repositoryNameImplement]');
    repositoryImpl.writeln('///[Implementation]');
    repositoryImpl.writeln('@Injectable(as:$repositoryName)');
    repositoryImpl
        .writeln('class $repositoryNameImplement implements $repositoryName {');
    repositoryImpl.writeln('final ${visitor.className} $clientService;');
    repositoryImpl.writeln('final SafeApi api;');

    ///[add cache]
    if (hasCache) {
      repositoryImpl.writeln('final SharedPreferences sharedPreferences;');
    }
    repositoryImpl.writeln('const $repositoryNameImplement(');
    repositoryImpl.writeln('this.$clientService,');
    repositoryImpl.writeln('this.api,');

    ///[add cache]
    if (hasCache) {
      repositoryImpl.writeln('this.sharedPreferences,');
    }
    repositoryImpl.writeln(');\n');
    for (var method in visitor.useCases) {
      final useCaseName = names.firstLower(method.name);
      final type = methodFormat.returnType(method.type);
      final responseDataType = names.responseDataType(type);
      repositoryImpl.writeln('@override');
      repositoryImpl.writeln(
          'Future<Either<Failure, $type>> $useCaseName(${methodFormat.parameters(method.parameters)})async {');
      repositoryImpl.writeln('return await api<$type>(');

      repositoryImpl.writeln(
          'apiCall: $clientService.${method.name}(${methodFormat.passingParameters(method.parameters)}),);');
      repositoryImpl.writeln('}\n');

      ///[cache save or get implement]
      if (method.comment?.contains('///cache') == true) {
        final useCaseName = names.firstUpper(method.name);
        final key = names.firstLower(useCaseName);
        repositoryImpl.writeln('final _$key = "${key.toUpperCase()}";');

        ///[cache]
        repositoryImpl.writeln('@override');
        repositoryImpl.writeln(
            'Future<Either<Failure, Unit>> cache$useCaseName({required $responseDataType data,}) async {');
        repositoryImpl.writeln('try {');
        final cachedType = _cacheType(responseDataType);
        final dynamicType = cachedType == 'dynamic';
        if (dynamicType) {
          if (responseDataType.contains('List')) {
            repositoryImpl.writeln(
                'await sharedPreferences.setString(_$key,jsonEncode(data.map((item)=> item.toJson()).toList()));');
          } else {
            repositoryImpl.writeln(
                'await sharedPreferences.setString(_$key, jsonEncode(data.toJson()));');
          }
        } else {
          repositoryImpl.writeln(
              'await sharedPreferences.set${names.firstUpper(cachedType)}(_$key, data);');
        }
        repositoryImpl.writeln('return const Right(unit);');
        repositoryImpl.writeln('} catch (e) {');
        repositoryImpl.writeln("return Left(Failure(12, 'Cash failure'));");
        repositoryImpl.writeln('}');
        repositoryImpl.writeln('}\n');

        ///[get]
        repositoryImpl.writeln('@override');
        repositoryImpl
            .writeln('Either<Failure, $responseDataType> get$useCaseName(){');
        repositoryImpl.writeln('try {');
        if (dynamicType) {
          repositoryImpl.writeln(
              "final res = sharedPreferences.getString(_$key) ?? '{}';");
          if (responseDataType.contains('List')) {
            repositoryImpl.writeln("$responseDataType data = [];");
            repositoryImpl.writeln("for (var item in jsonDecode(res)) {");
            repositoryImpl.writeln("data.add($cachedType.fromJson());");
            repositoryImpl.writeln("}");
            repositoryImpl.writeln("return Right(data);");
          } else {
            repositoryImpl.writeln(
                "return Right($cachedType.fromJson(jsonDecode(res)));");
          }
        } else {
          repositoryImpl.writeln(
              "final res = sharedPreferences.get${names.firstUpper(cachedType)}(_$key) ?? '';");
          repositoryImpl.writeln('return Right(res);');
        }
        repositoryImpl.writeln('} catch (e) {');
        repositoryImpl.writeln("return Left(Failure(12, 'Cash failure'));");
        repositoryImpl.writeln('}');
        repositoryImpl.writeln('}\n');
      }
    }
    repositoryImpl.writeln('}\n');
    AddFile.save('$path/${repositoryName}Impl', repositoryImpl.toString());
    repository.writeln(repositoryImpl);
    return repository.toString();
  }

  String _cacheType(dynamic type) {
    if (type is int || type is String || type is bool || type is double) {
      return type.toString();
    }
    return 'dynamic';
  }
}
