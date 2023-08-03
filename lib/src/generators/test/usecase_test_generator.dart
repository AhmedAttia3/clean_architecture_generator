import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:mvvm_generator/formatter/method_format.dart';
import 'package:mvvm_generator/formatter/names.dart';
import 'package:mvvm_generator/src/add_file_to_project.dart';
import 'package:mvvm_generator/src/mvvm_generator_annotations.dart';
import 'package:mvvm_generator/src/read_imports_file.dart';
import 'package:source_gen/source_gen.dart';

import '../../model_visitor.dart';

class UseCaseTestGenerator extends GeneratorForAnnotation<MVVMAnnotation> {
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
    final basePath =
        AddFile.path(buildStep.inputId.path).replaceFirst('lib', 'test');
    final path = "$basePath/repository/use-cases";

    final classBuffer = StringBuffer();

    for (var method in visitor.useCases) {
      final methodName = method.name;
      final repositoryName = '${names.firstUpper(visitor.className)}Repository';
      final useCaseType = '${names.firstUpper(method.name)}UseCase';
      final useCaseName = '${names.firstLower(method.name)}UseCase';
      final requestName = '${names.firstUpper(method.name)}Request';
      final type = methodFormat.returnType(method.type);
      final modelType = names.baseModelName(type);
      final fileName = "${names.camelCaseToUnderscore(useCaseType)}_test";
      final usecase = StringBuffer();

      ///[Imports]
      usecase.writeln(Imports.create(
        imports: [
          useCaseType,
          method.parameters.isEmpty ? "" : requestName,
          repositoryName,
        ],
        filePath: buildStep.inputId.path,
        isTest: true,
      ));
      usecase.writeln("import '$fileName.mocks.dart';");
      usecase.writeln('@GenerateNiceMocks([');
      usecase.writeln('MockSpec<$repositoryName>(),');
      usecase.writeln('])');
      usecase.writeln('void main() {');
      usecase.writeln('late $useCaseType $useCaseName;');
      usecase.writeln('late $repositoryName repository;');
      usecase.writeln('late $type success;');
      usecase.writeln('late Failure failure;');
      usecase.writeln('setUp(() {');
      usecase.writeln('repository = Mock$repositoryName();');
      usecase.writeln('$useCaseName = $useCaseType(repository);');
      usecase.writeln("failure = Failure(1, 'message');");
      usecase.writeln("success = $type(");
      usecase.writeln("message: 'message',");
      usecase.writeln("success: true,");
      if (type.contains('BaseResponse<dynamic>')) {
        usecase.writeln("data: null,);");
      } else {
        final model = names.camelCaseToUnderscore(names.baseModelName(type));
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

      final request =
          "$requestName(${methodFormat.parametersWithValues(method.parameters)})";
      usecase.writeln(
          "webService() => repository.$methodName(${methodFormat.parametersWithValues(method.parameters)});\n");
      usecase.writeln("group('$useCaseType ', () {");
      usecase.writeln("test('$methodName FAILURE', () async {");
      usecase.writeln(
          "when(webService()).thenAnswer((realInvocation) async => Left(failure));");
      usecase.writeln("final res = await $useCaseName.execute(");
      if (method.parameters.isNotEmpty) {
        usecase.writeln("request: const $request);");
      } else {
        usecase.writeln(");");
      }
      usecase.writeln("expect(res.left((data) {}), failure);");
      usecase.writeln("verify(webService());");
      usecase.writeln("verifyNoMoreInteractions(repository);");
      usecase.writeln("});\n\n");
      usecase.writeln("test('$methodName SUCCESS', () async {");
      usecase.writeln(
          "when(webService()).thenAnswer((realInvocation) async => Right(success));");
      usecase.writeln("final res = await $useCaseName.execute(");
      if (method.parameters.isNotEmpty) {
        usecase.writeln("request: $request);");
      } else {
        usecase.writeln(");");
      }
      usecase.writeln("expect(res.right((data) {}), success);");
      usecase.writeln("verify(webService());");
      usecase.writeln("verifyNoMoreInteractions(repository);");
      usecase.writeln("});");
      usecase.writeln("});");
      usecase.writeln("}");

      AddFile.save("$path/${useCaseType}Test", usecase.toString());
      classBuffer.writeln(usecase);
    }
    return classBuffer.toString();
  }
}
