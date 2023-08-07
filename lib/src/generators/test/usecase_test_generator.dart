import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/clean_architecture_generator.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/imports_file.dart';
import 'package:source_gen/source_gen.dart';

import '../../model_visitor.dart';

class UseCaseTestGenerator
    extends GeneratorForAnnotation<ArchitectureTDDAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    const expectedPath = "test";
    final visitor = ModelVisitor();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);
    final basePath = AddFile.getDirectories(buildStep.inputId.path)
        .replaceFirst('lib', 'test');
    final path = "$basePath/domain/use-cases";

    List<String> imports = [];
    for (var method in visitor.useCases) {
      final returnType = methodFormat.returnType(method.type);
      final type = methodFormat.responseType(returnType);
      if (method.requestType == RequestType.Body) {
        final request = names.requestType(method.name);
        imports.add(request);
      }
      imports.add(type);
    }

    final classBuffer = StringBuffer();

    for (var method in visitor.useCases) {
      final methodName = method.name;
      final repositoryType = names.repositoryType(visitor.className);
      final useCaseType = names.useCaseType(methodName);
      final useCaseName = names.useCaseName(methodName);
      final requestType = names.requestType(methodName);
      final type = methodFormat.returnType(method.type);
      final modelType = names.ModelType(type);
      final varType = names.modelRuntimeType(modelType);
      final requestName = names.requestName(method.name);
      final fileName = "${names.camelCaseToUnderscore(useCaseType)}_test";
      final usecase = StringBuffer();

      ///[Imports]
      usecase.writeln(Imports.create(
        imports: [
          useCaseType,
          method.hasRequest ? "" : requestType,
          repositoryType,
          ...imports,
          'base_response',
        ],
        isTest: true,
      ));
      usecase.writeln("import '$fileName.mocks.dart';");
      usecase.writeln('@GenerateNiceMocks([');
      usecase.writeln('MockSpec<$repositoryType>(),');
      usecase.writeln('])');
      usecase.writeln('void main() {');
      usecase.writeln('late $useCaseType $useCaseName;');
      usecase.writeln('late $repositoryType repository;');
      usecase.writeln('late $type success;');
      usecase.writeln('late Failure failure;');
      if (method.requestType == RequestType.Body || method.hasRequest) {
        usecase.writeln('late $requestType $requestName;');
      }
      usecase.writeln('setUp(() {');
      usecase.writeln('repository = Mock$repositoryType();');
      usecase.writeln('$useCaseName = $useCaseType(repository);');
      usecase.writeln("failure = Failure(1, 'message');");
      usecase.writeln("success = $type(");
      usecase.writeln("message: 'message',");
      usecase.writeln("success: true,");
      if (varType == 'int' ||
          varType == 'double' ||
          varType == 'num' ||
          varType == 'String' ||
          varType == 'Map' ||
          varType == 'bool') {
        usecase.writeln("data: ${methodFormat.initData(varType, 'name')},);");
      } else if (type.contains('BaseResponse<dynamic>')) {
        usecase.writeln("data: null,);");
      } else {
        final model = names.camelCaseToUnderscore(names.ModelType(type));
        AddFile.save(
          "$expectedPath/expected/expected_$model",
          '{}',
          extension: 'json',
        );
        final decode =
            "jsonDecode(File('test/expected/expected_$model.json').readAsStringSync())";
        if (type.contains('List')) {
          usecase.writeln("data: List.generate(");
          usecase.writeln("2,");
          usecase.writeln("(index) =>");
          usecase.writeln("$modelType.fromJson($decode),");
          usecase.writeln("));");
        } else {
          usecase.writeln("data: $modelType.fromJson($decode),);");
        }
      }
      usecase.writeln("});\n");
      if (method.requestType == RequestType.Body || method.hasRequest) {
        usecase.writeln(
            "$requestName = $requestType(${methodFormat.parametersWithValues(method.parameters)});\n");
      }
      if (method.requestType == RequestType.Fields || !method.hasRequest) {
        usecase.writeln(
            "webService() => repository.$methodName(${methodFormat.parametersWithValues(method.parameters)});\n");
      } else {
        usecase.writeln(
            "webService() => repository.$methodName(request : $requestName);\n");
      }

      usecase.writeln("group('$useCaseType ', () {");
      usecase.writeln("test('$methodName FAILURE', () async {");
      usecase.writeln(
          "when(webService()).thenAnswer((realInvocation) async => Left(failure));");
      usecase.writeln("final res = await $useCaseName.execute(");
      if (method.hasRequest) {
        usecase.writeln("request: $requestName);");
      } else if (method.parameters.length == 1 &&
          method.requestType == RequestType.Fields) {
        usecase.writeln("request: $requestName);");
      } else {
        final request = methodFormat.parametersWithValues(method.parameters);
        usecase.writeln("$request);");
      }
      usecase.writeln("expect(res.left((data) {}), failure);");
      usecase.writeln("verify(webService());");
      usecase.writeln("verifyNoMoreInteractions(repository);");
      usecase.writeln("});\n\n");
      usecase.writeln("test('$methodName SUCCESS', () async {");
      usecase.writeln(
          "when(webService()).thenAnswer((realInvocation) async => Right(success));");
      usecase.writeln("final res = await $useCaseName.execute(");
      if (method.hasRequest) {
        usecase.writeln("request: $requestName);");
      } else if (method.parameters.length == 1 &&
          method.requestType == RequestType.Fields) {
        usecase.writeln(
            "request: ${methodFormat.parametersWithValues(method.parameters)});");
      } else {
        final request = methodFormat.parametersWithValues(method.parameters);
        usecase.writeln("$request);");
      }
      usecase.writeln("expect(res.right((data) {}), success);");
      usecase.writeln("verify(webService());");
      usecase.writeln("verifyNoMoreInteractions(repository);");
      usecase.writeln("});");
      usecase.writeln("});");
      usecase.writeln("}");

      AddFile.save(
        "$path/${useCaseType}Test",
        usecase.toString(),
        allowUpdates: true,
      );
      classBuffer.writeln(usecase);
    }
    return classBuffer.toString();
  }
}
