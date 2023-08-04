import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/annotations.dart';
import 'package:clean_architecture_generator/src/read_imports_file.dart';
import 'package:source_gen/source_gen.dart';

import '../../model_visitor.dart';

class RepositoryTestGenerator
    extends GeneratorForAnnotation<ArchitectureAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    const expectedPath = "test";
    final basePath = AddFile.getDirectories(buildStep.inputId.path)
        .replaceFirst('lib', 'test');
    final path = "$basePath/domain/repository";
    final visitor = ModelVisitor();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);
    final classBuffer = StringBuffer();

    bool hasCache = false;

    ///[HasCache]
    for (var method in visitor.useCases) {
      if (method.isCache) {
        hasCache = true;
        break;
      }
    }

    final localDataSourceType = names.localDataSourceType(visitor.className);
    final localDataSourceName = names.firstLower(localDataSourceType);
    final remoteDataSourceType = names.firstUpper(visitor.className);
    final repositoryType = '${remoteDataSourceType}Repository';
    final repositoryImplementType =
        '${remoteDataSourceType}RepositoryImplement';
    final fileName = "${names.camelCaseToUnderscore(repositoryType)}_test";

    ///[Imports]
    classBuffer.writeln(Imports.create(
      imports: [
        localDataSourceType,
        remoteDataSourceType,
        '${repositoryType}Impl',
        repositoryType,
        "Network",
        "Failure",
      ],
      filePath: buildStep.inputId.path,
      isTest: true,
    ));
    classBuffer.writeln("import '$fileName.mocks.dart';");
    classBuffer.writeln('@GenerateNiceMocks([');
    classBuffer.writeln('MockSpec<$remoteDataSourceType>(),');
    classBuffer.writeln('MockSpec<NetworkInfo>(),');
    if (hasCache) classBuffer.writeln('MockSpec<$localDataSourceType>(),');
    classBuffer.writeln('])');
    classBuffer.writeln('void main() {');
    classBuffer.writeln('late $remoteDataSourceType dataSource;');
    classBuffer.writeln('late $repositoryType repository;');
    classBuffer.writeln('late Failure failure;');
    classBuffer.writeln('late SafeApi apiCall;');
    classBuffer.writeln('late NetworkInfo networkInfo;');
    classBuffer.writeln('late $localDataSourceType $localDataSourceName;');

    for (var method in visitor.useCases) {
      final methodName = method.name;
      final type = methodFormat.returnType(method.type);
      classBuffer.writeln('late $type ${methodName}Response;');
      if (method.isCache) {
        final modelType = names.baseModelName(type);
        final dataType = names.responseDataType(type);
        final dataName = "${names.firstLower(modelType)}s";
        classBuffer.writeln('late $dataType $dataName;');
      }
    }

    classBuffer.writeln('setUp(() {');
    if (hasCache) {
      classBuffer.writeln('$localDataSourceName = Mock$localDataSourceType();');
    }
    classBuffer.writeln('failure = Failure(999,"Cache failure");');
    classBuffer.writeln('networkInfo = MockNetworkInfo();');
    classBuffer.writeln('apiCall = SafeApi(networkInfo);');
    classBuffer.writeln('dataSource = Mock$remoteDataSourceType();');
    classBuffer.writeln('repository = $repositoryImplementType(');
    classBuffer.writeln('dataSource,');
    if (hasCache) classBuffer.writeln('$localDataSourceName,');
    classBuffer.writeln('apiCall,');
    classBuffer.writeln(');');

    for (var method in visitor.useCases) {
      final methodName = method.name;
      final type = methodFormat.returnType(method.type);
      final modelType = names.baseModelName(type);
      final varType = names.varType(modelType);
      classBuffer.writeln("///[${names.firstUpper(methodName)}]");
      classBuffer.writeln('${methodName}Response = $type(');
      classBuffer.writeln("message: 'message',");
      classBuffer.writeln("success: true,");
      if (varType == 'int' ||
          varType == 'double' ||
          varType == 'num' ||
          varType == 'String' ||
          varType == 'Map' ||
          varType == 'bool') {
        classBuffer
            .writeln("data: ${methodFormat.initData(varType, 'name')},);");
      } else if (type.contains('BaseResponse<dynamic>')) {
        classBuffer.writeln("data: null,);");
      } else {
        final model = names.camelCaseToUnderscore(names.baseModelName(type));
        AddFile.save(
          "$expectedPath/expected/expected_$model",
          '{}',
          extension: 'json',
        );
        final decode = "fromJson('expected_$model')";
        if (type.contains('List')) {
          classBuffer.writeln("data: List.generate(");
          classBuffer.writeln("2,");
          classBuffer.writeln("(index) =>");
          classBuffer.writeln("$modelType.fromJson($decode),");
          classBuffer.writeln("));");
        } else {
          classBuffer.writeln("data: $modelType.fromJson($decode),);");
        }
      }
      if (method.isCache) {
        final model = names.camelCaseToUnderscore(names.baseModelName(type));
        final decode = "fromJson('expected_$model')";
        final dataName = "${names.firstLower(modelType)}s";
        if (type.contains('List')) {
          classBuffer.writeln("$dataName = List.generate(");
          classBuffer.writeln("2,");
          classBuffer.writeln("(index) =>");
          classBuffer.writeln("$modelType.fromJson($decode),");
          classBuffer.writeln(");");
        } else {
          classBuffer.writeln("$dataName = $modelType.fromJson($decode);");
        }
      }
    }
    classBuffer.writeln('});');

    for (var method in visitor.useCases) {
      final methodName = method.name;
      classBuffer.writeln(
          "$methodName() => dataSource.$methodName(${methodFormat.parametersWithValues(method.parameters)});");

      if (method.isCache) {
        final getCacheMethodName =
            "getCache${names.firstUpper(methodName).replaceFirst('Get', '')}";
        final cacheMethodName =
            "cache${names.firstUpper(methodName).replaceFirst('Get', '')}";
        final type = methodFormat.returnType(method.type);
        final modelType = names.baseModelName(type);
        final dataName = "${names.firstLower(modelType)}s";
        classBuffer.writeln(
            "$cacheMethodName() => $localDataSourceName.$cacheMethodName(data : $dataName);\n");

        classBuffer.writeln(
            "$getCacheMethodName() => $localDataSourceName.$getCacheMethodName();\n");
      }
    }

    classBuffer.writeln("group('$repositoryType Repository', () {");
    if (visitor.useCases.isNotEmpty) {
      classBuffer.writeln("///[No Internet Test]");
      classBuffer.writeln("test('No Internet', () async {");
      classBuffer.writeln(
          "when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);");
      final method = visitor.useCases.first;
      if (method.parameters.isNotEmpty) {
        final request = methodFormat.parametersWithValues(method.parameters);
        classBuffer
            .writeln("final res = await repository.${method.name}($request);");
      } else {
        classBuffer.writeln("final res = await repository.${method.name}();");
      }
      classBuffer.writeln("expect(res.leftOrNull(), isA<Failure>());");
      classBuffer.writeln("verify(networkInfo.isConnected);");
      classBuffer.writeln("verifyNoMoreInteractions(networkInfo);");
      classBuffer.writeln("});\n");

      for (var method in visitor.useCases) {
        final methodName = method.name;

        ///[Function Success Test]
        classBuffer.writeln("///[$methodName Success Test]");
        classBuffer.writeln("test('$methodName Success', () async {");
        classBuffer.writeln(
            "when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);");
        classBuffer.writeln("when($methodName())");
        classBuffer.writeln(
            ".thenAnswer((realInvocation) async => ${methodName}Response);");
        if (method.parameters.isNotEmpty) {
          final request = methodFormat.parametersWithValues(method.parameters);
          classBuffer
              .writeln("final res = await repository.$methodName($request);");
        } else {
          classBuffer.writeln("final res = await repository.$methodName();");
        }
        classBuffer
            .writeln("expect(res.rightOrNull(), ${methodName}Response);");
        classBuffer.writeln("verify(networkInfo.isConnected);");
        classBuffer.writeln("verify($methodName());");
        classBuffer.writeln("verifyNoMoreInteractions(networkInfo);");
        classBuffer.writeln("verifyNoMoreInteractions(dataSource);");
        classBuffer.writeln("});\n");

        ///[Function Failure Test]
        classBuffer.writeln("///[$methodName Failure Test]");
        classBuffer.writeln("test('$methodName Failure', () async {");
        classBuffer.writeln(
            "when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);");
        classBuffer.writeln("when($methodName())");
        classBuffer.writeln(
            ".thenAnswer((realInvocation) async => ${methodName}Response);");
        if (method.parameters.isNotEmpty) {
          final request = methodFormat.parametersWithValues(method.parameters);
          classBuffer
              .writeln("final res = await repository.$methodName($request);");
        } else {
          classBuffer.writeln("final res = await repository.$methodName();");
        }
        classBuffer.writeln("expect(res.leftOrNull(), isA<Failure>());");
        classBuffer.writeln("verify(networkInfo.isConnected);");
        classBuffer.writeln("verify($methodName());");
        classBuffer.writeln("verifyNoMoreInteractions(networkInfo);");
        classBuffer.writeln("verifyNoMoreInteractions(dataSource);");
        classBuffer.writeln("});\n");

        ///[Cache Test]
        if (method.isCache) {
          final getCacheMethodName =
              "getCache${names.firstUpper(methodName).replaceFirst('Get', '')}";
          final cacheMethodName =
              "cache${names.firstUpper(methodName).replaceFirst('Get', '')}";
          final type = methodFormat.returnType(method.type);
          final modelType = names.baseModelName(type);
          final dataName = "${names.firstLower(modelType)}s";
          final dataType = names.responseDataType(type);

          ///[Cache]
          classBuffer.writeln("///[$cacheMethodName Success]");
          classBuffer.writeln("test('$cacheMethodName', () async {");
          classBuffer.writeln(
              "when($cacheMethodName()).thenAnswer((realInvocation) async => const Right(unit));");
          classBuffer.writeln(
              "final res = await repository.$cacheMethodName(data:$dataName);");
          classBuffer.writeln("expect(res.rightOrNull(), unit);");
          classBuffer.writeln("verify($cacheMethodName());");
          classBuffer
              .writeln("verifyNoMoreInteractions($localDataSourceName);");
          classBuffer.writeln("});\n");

          classBuffer.writeln("///[$cacheMethodName Failure]");
          classBuffer.writeln("test('$cacheMethodName', () async {");
          classBuffer.writeln(
              "when($cacheMethodName()).thenAnswer((realInvocation) async => Left(failure));");
          classBuffer.writeln(
              "final res = await repository.$cacheMethodName(data:$dataName);");
          classBuffer.writeln("expect(res.leftOrNull(), isA<Failure>());");
          classBuffer.writeln("verify($cacheMethodName());");
          classBuffer
              .writeln("verifyNoMoreInteractions($localDataSourceName);");
          classBuffer.writeln("});\n");

          ///[Get Cache]
          classBuffer.writeln("///[$getCacheMethodName Success]");
          classBuffer.writeln("test('$getCacheMethodName', () async {");
          classBuffer.writeln(
              "when($getCacheMethodName()).thenAnswer((realInvocation) => Right($dataName));\n");
          classBuffer.writeln("final res = repository.$getCacheMethodName();");
          classBuffer.writeln("expect(res.rightOrNull(),isA<$dataType>());");
          classBuffer.writeln("verify($getCacheMethodName());");
          classBuffer
              .writeln("verifyNoMoreInteractions($localDataSourceName);");
          classBuffer.writeln("});\n");

          classBuffer.writeln("///[$getCacheMethodName Failure]");
          classBuffer.writeln("test('$getCacheMethodName', () async {");
          classBuffer.writeln(
              "when($getCacheMethodName()).thenAnswer((realInvocation) => Left(failure));\n");
          classBuffer.writeln("final res = repository.$getCacheMethodName();");
          classBuffer.writeln("expect(res.leftOrNull(),isA<Failure>());");
          classBuffer.writeln("verify($getCacheMethodName());");
          classBuffer
              .writeln("verifyNoMoreInteractions($localDataSourceName);");
          classBuffer.writeln("});\n");
        }
      }
    }
    classBuffer.writeln("});");
    classBuffer.writeln("}\n");
    classBuffer.writeln("///[FromJson]");
    classBuffer.writeln("Map<String, dynamic> fromJson(String path) {");
    classBuffer.writeln(
        " return jsonDecode(File('test/expected/\$path.json').readAsStringSync());");
    classBuffer.writeln("}");
    AddFile.save(
      '$path/${repositoryType}Test',
      classBuffer.toString(),
      allowUpdates: true,
    );
    return classBuffer.toString();
  }
}
