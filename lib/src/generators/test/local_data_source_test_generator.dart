import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/annotations.dart';
import 'package:clean_architecture_generator/src/read_imports_file.dart';
import 'package:source_gen/source_gen.dart';

import '../../model_visitor.dart';

class LocalDataSourceTestGenerator
    extends GeneratorForAnnotation<ArchitectureAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final basePath = AddFile.getDirectories(buildStep.inputId.path)
        .replaceFirst('lib', 'test');
    final path = "$basePath/data/data-sources";
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
    final localDataSourceName = names.localDataSourceName(visitor.className);
    final fileName = "${names.camelCaseToUnderscore(localDataSourceType)}_test";

    ///[Imports]
    classBuffer.writeln(Imports.create(
      isTest: true,
      filePath: buildStep.inputId.path,
      imports: [
        localDataSourceType,
        '${localDataSourceType}Impl',
      ],
      libs: ["import 'package:shared_preferences/shared_preferences.dart';"],
    ));

    classBuffer.writeln("import '$fileName.mocks.dart';");
    classBuffer.writeln('@GenerateNiceMocks([');
    if (hasCache) classBuffer.writeln('MockSpec<SharedPreferences>(),');
    classBuffer.writeln('])');
    classBuffer.writeln('void main() {');
    classBuffer.writeln('late $localDataSourceType $localDataSourceName;');
    classBuffer.writeln('late SharedPreferences sharedPreferences;');

    for (var method in visitor.useCases) {
      if (method.isCache) {
        final type = methodFormat.returnType(method.type);
        final modelType = names.baseModelName(type);
        final dataType = names.responseType(type);
        final dataName = "${names.firstLower(modelType)}Cache";
        classBuffer.writeln('late $dataType $dataName;');
      }
    }

    classBuffer.writeln('setUp(() {');
    if (hasCache) {
      classBuffer.writeln('sharedPreferences = MockSharedPreferences();');
    }
    classBuffer.writeln('$localDataSourceName = ${localDataSourceType}Impl(');
    if (hasCache) classBuffer.writeln('sharedPreferences,');
    classBuffer.writeln(');');

    for (var method in visitor.useCases) {
      if (method.isCache) {
        final type = methodFormat.returnType(method.type);
        final modelType = names.baseModelName(type);
        final varType = names.varType(modelType);
        final model = names.camelCaseToUnderscore(names.baseModelName(type));
        final decode = "fromJson('expected_$model')";
        final dataName = "${names.firstLower(modelType)}Cache";
        if (varType == 'int' ||
            varType == 'double' ||
            varType == 'num' ||
            varType == 'String' ||
            varType == 'Map' ||
            varType == 'bool') {
          classBuffer.writeln(
              "$dataName = ${methodFormat.initData(varType, 'name')};");
        } else if (type.contains('List')) {
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
      if (method.isCache) {
        final methodName = method.name;
        final key = names.key(methodName);
        final getCacheMethodName = names.getCacheName(methodName);
        final cacheMethodName = names.cacheName(methodName);
        final type = methodFormat.returnType(method.type);
        final modelType = names.baseModelName(type);
        classBuffer.writeln(
            "$cacheMethodName() => sharedPreferences.setString('$key',");
        final dataName = "${names.firstLower(modelType)}Cache";
        if (type.contains('List')) {
          classBuffer.writeln("jsonEncode($dataName.map((item)=>");
          classBuffer.writeln("item.toJson()).toList()),);\n");
        } else {
          classBuffer.writeln("jsonEncode($dataName.toJson()),);\n");
        }
        classBuffer.writeln(
            "$getCacheMethodName() => sharedPreferences.getString('$key');\n");
      }
    }

    classBuffer.writeln("group('$localDataSourceType', () {");
    if (visitor.useCases.isNotEmpty) {
      for (var method in visitor.useCases) {
        ///[Cache Test]
        if (method.isCache) {
          final methodName = method.name;
          final getCacheMethodName = names.getCacheName(methodName);
          final cacheMethodName = names.cacheName(methodName);
          final type = methodFormat.returnType(method.type);
          final modelType = names.baseModelName(type);
          final dataName = "${names.firstLower(modelType)}Cache";
          final dataType = names.responseType(type);

          ///[Cache]
          classBuffer.writeln("///[$cacheMethodName Test]");
          classBuffer.writeln("test('$cacheMethodName', () async {");
          classBuffer.writeln(
              "when($cacheMethodName()).thenAnswer((realInvocation) async => true);");
          classBuffer.writeln(
              "final res = await $localDataSourceName.$cacheMethodName(data:$dataName);");
          classBuffer.writeln("expect(res.rightOrNull(), unit);");
          classBuffer.writeln("verify($cacheMethodName());");
          classBuffer.writeln("verifyNoMoreInteractions(sharedPreferences);");
          classBuffer.writeln("});\n");

          ///[Get Cache]
          classBuffer.writeln("///[$getCacheMethodName Test]");
          classBuffer.writeln("test('$getCacheMethodName', () async {");
          classBuffer.writeln(
              "when($getCacheMethodName()).thenAnswer((realInvocation) => ");
          if (type.contains('List')) {
            classBuffer.writeln("jsonEncode($dataName.map((item)=>");
            classBuffer.writeln("item.toJson()).toList()),);\n");
          } else {
            classBuffer.writeln("jsonEncode($dataName.toJson()),);\n");
          }
          classBuffer.writeln(
              "final res = $localDataSourceName.$getCacheMethodName();");
          classBuffer.writeln("expect(res.rightOrNull(),isA<$dataType>());");
          classBuffer.writeln("verify($getCacheMethodName());");
          classBuffer.writeln("verifyNoMoreInteractions(sharedPreferences);");
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
      '$path/${localDataSourceType}Test',
      classBuffer.toString(),
      allowUpdates: true,
    );
    return classBuffer.toString();
  }
}
