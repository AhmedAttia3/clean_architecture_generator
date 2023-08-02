import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:mvvm_generator/formatter/method_format.dart';
import 'package:mvvm_generator/formatter/names.dart';
import 'package:mvvm_generator/src/add_file_to_project.dart';
import 'package:mvvm_generator/src/mvvm_generator_annotations.dart';
import 'package:mvvm_generator/src/read_imports_file.dart';
import 'package:source_gen/source_gen.dart';

import '../../model_visitor.dart';

class RepositoryTestGenerator extends GeneratorForAnnotation<MVVMAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    const expectedPath = "test";
    final basePath =
        AddFile.path(buildStep.inputId.path).replaceFirst('lib', 'test');
    final path = "$basePath/repository/data-source";
    final visitor = ModelVisitor();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);
    final classBuffer = StringBuffer();

    final remoteDataSourceType = names.firstUpper(visitor.className);
    final repositoryType = '${remoteDataSourceType}Repository';
    final repositoryImplementType =
        '${remoteDataSourceType}RepositoryImplement';
    final fileName = "${names.camelCaseToUnderscore(repositoryType)}_test";
    classBuffer.writeln(Imports.create(
      imports: [
        remoteDataSourceType,
        '${repositoryType}Impl',
        repositoryType,
        "Network",
      ],
      filePath: buildStep.inputId.path,
      isTest: true,
    ));
    classBuffer.writeln("import '$fileName.mocks.dart';");
    classBuffer.writeln('@GenerateNiceMocks([');
    classBuffer.writeln('MockSpec<$remoteDataSourceType>(),');
    classBuffer.writeln('MockSpec<NetworkInfo>(),');
    classBuffer.writeln('])');
    classBuffer.writeln('void main() {');
    classBuffer.writeln('late $remoteDataSourceType dataSource;');
    classBuffer.writeln('late $repositoryType repository;');
    classBuffer.writeln('late SafeApi apiCall;');
    classBuffer.writeln('late NetworkInfo networkInfo;');

    for (var method in visitor.useCases) {
      final methodName = method.name;
      final type = methodFormat.returnType(method.type);
      classBuffer.writeln('late $type ${methodName}Response;');
    }

    classBuffer.writeln('setUp(() {');
    classBuffer.writeln('networkInfo = MockNetworkInfo();');
    classBuffer.writeln('apiCall = SafeApi(networkInfo);');
    classBuffer.writeln('dataSource = Mock$remoteDataSourceType();');
    classBuffer.writeln('repository = $repositoryImplementType(');
    classBuffer.writeln('dataSource,');
    classBuffer.writeln('apiCall,');
    classBuffer.writeln(');');

    for (var method in visitor.useCases) {
      final methodName = method.name;
      final type = methodFormat.returnType(method.type);
      final modelType = names.baseModelName(type);
      classBuffer.writeln("///[${names.firstUpper(methodName)}]");
      classBuffer.writeln('${methodName}Response = $type(');
      classBuffer.writeln("message: 'message',");
      classBuffer.writeln("success: true,");
      if (type.contains('BaseResponse<dynamic>')) {
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
    }
    classBuffer.writeln('});');

    for (var method in visitor.useCases) {
      final methodName = method.name;
      classBuffer.writeln(
          "$methodName() => dataSource.$methodName(${methodFormat.parametersWithValues(method.parameters)});");
    }

    classBuffer.writeln("\ngroup('$repositoryType Repository', () {");
    if (visitor.useCases.isNotEmpty) {
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
        classBuffer.writeln("test('$methodName', () async {");
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
      }
    }
    classBuffer.writeln("});");
    classBuffer.writeln("}\n");
    classBuffer.writeln("Map<String, dynamic> fromJson(String path) {");
    classBuffer.writeln(
        " return jsonDecode(File('test/expected/\$path.json').readAsStringSync());");
    classBuffer.writeln("}");
    AddFile.save('$path/${repositoryType}Test', classBuffer.toString());
    return classBuffer.toString();
  }
}
