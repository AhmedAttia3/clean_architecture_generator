import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:generators/formatter/method_format.dart';
import 'package:generators/formatter/names.dart';
import 'package:generators/src/add_file_to_project.dart';
import 'package:generators/src/read_imports_file.dart';
import 'package:source_gen/source_gen.dart';

import '../../model_visitor.dart';

class UseCaseTestGenerator
    extends GeneratorForAnnotation<UseCaseTestAnnotation> {
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

    final basePath =
        AddFile.path(buildStep.inputId.path).replaceFirst('lib', 'test');
    final classBuffer = StringBuffer();
    final remoteDataSourceName = names.firstLower(visitor.className);
    final remoteDataSourceType = names.firstUpper(visitor.className);

    for (var method in visitor.useCases) {
      final path = "$basePath/${visitor.className}";
      final methodName = method.name;
      final repositoryName = '${names.firstUpper(visitor.className)}Repository';
      final useCaseType = '${names.firstUpper(method.name)}UseCase';
      final useCaseName = '${names.firstLower(method.name)}UseCase';
      final requestName = '${names.firstUpper(method.name)}Request';
      final type = methodFormat.returnType(method.type);
      final fileName = "${names.camelCaseToUnderscore(useCaseType)}_test";
      final usecase = StringBuffer();

      usecase.writeln("import 'package:eitherx/eitherx.dart';");
      usecase.writeln("import 'package:flutter_test/flutter_test.dart';");
      usecase.writeln("import 'package:mockito/mockito.dart';");
      usecase.writeln("import 'package:mockito/annotations.dart';");
      usecase.writeln("import '$fileName.mocks.dart';");
      usecase.writeln(imports(
        requestName: requestName,
        useCaseName: useCaseType,
        baseFilePath: buildStep.inputId.path,
      ));
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
      usecase.writeln('useCaseName = $useCaseType(repository);');
      usecase.writeln("failure = Failure(1, 'message');");
      usecase.writeln("success = $type(");
      usecase.writeln("message: 'message',");
      usecase.writeln("success: true,");
      if (type.contains('BaseResponse<dynamic>')) {
        usecase.writeln("data: null,);");
      } else {
        final model = names.baseModelName(type);
        final expectedModel = "expected_${names.camelCaseToUnderscore(model)}";
        if (type.contains('List')) {
          usecase.writeln("data: List.generate(");
          usecase.writeln("2,");
          usecase.writeln("(index) =>");
          usecase.writeln("$model.fromJson(Encode.set('$expectedModel'))),");
          usecase.writeln(");");
          usecase.writeln("});");
        } else {
          usecase.writeln(
              "data: $model.fromJson(Encode.set('$expectedModel')),);");
        }
      }
      final request =
          "$requestName(${methodFormat.passingParametersWithInitValues(method.parameters)})";
      usecase.writeln("webService() => repository.$methodName();");
      usecase.writeln("group('$useCaseType ', () {");
      usecase.writeln("test('$methodName FAILURE', () async {");
      usecase.writeln(
          "when(webService()).thenAnswer((realInvocation) async => Left(failure));");
      usecase.writeln("final res = await $useCaseName.execute(");
      usecase.writeln("request: $request);");
      usecase.writeln("expect(res.left((data) {}), failure);");
      usecase.writeln("expect(res.left((data) {}), failure);");
      usecase.writeln("verify(webService());");
      usecase.writeln("verifyNoMoreInteractions(repository);");
      usecase.writeln("});\n\n");
      usecase.writeln("test('$methodName SUCCESS', () async {");
      usecase.writeln(
          "when(webService()).thenAnswer((realInvocation) async => Right(success));");
      usecase.writeln("final res = await $useCaseName.execute(");
      usecase.writeln("request: $request);");
      usecase.writeln("expect(res.right((data) {}), success);");
      usecase.writeln("verify(webService());");
      usecase.writeln("verifyNoMoreInteractions(repository);");
      usecase.writeln("});");
      usecase.writeln("});");
      usecase.writeln("}");

      AddFile.save("$basePath/$fileName.dart", usecase.toString());
      classBuffer.writeln(usecase);
    }
    return classBuffer.toString();
  }

  String imports({
    required String baseFilePath,
    required String useCaseName,
    required String requestName,
  }) {
    String data = ReadImports.file(baseFilePath);
    data += "import 'package:eitherx/eitherx.dart';\n";
    data += "import 'package:injectable/injectable.dart';\n";
    data +=
        "import '../use-cases/${names.camelCaseToUnderscore(useCaseName)}.dart';\n";
    data +=
        "import '../requests/${names.camelCaseToUnderscore(requestName)}.dart';\n";
    return data;
  }
}
