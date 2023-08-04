import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/annotations.dart';
import 'package:clean_architecture_generator/src/read_imports_file.dart';
import 'package:source_gen/source_gen.dart';

import '../../model_visitor.dart';

class GetCacheUseCaseTestGenerator
    extends GeneratorForAnnotation<ArchitectureAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    final methodFormat = MethodFormat();
    final basePath = AddFile.getDirectories(buildStep.inputId.path)
        .replaceFirst('lib', 'test');
    final path = "$basePath/domain/use-cases";

    final classBuffer = StringBuffer();

    for (var method in visitor.useCases) {
      final methodName =
          "getCache${names.firstUpper(method.name)}".replaceFirst('Get', '');
      final useCaseName = '${methodName}UseCase';
      final repositoryName = '${names.firstUpper(visitor.className)}Repository';
      final useCaseType = names.firstUpper(useCaseName);
      final type = methodFormat.returnType(method.type);
      final responseType = names.responseDataType(type);
      final modelType = names.baseModelName(type);
      final fileName = "${names.camelCaseToUnderscore(useCaseType)}_test";
      final usecase = StringBuffer();
      if (method.isCache) {
        ///[Test Get Caching]
        ///[Imports]
        usecase.writeln(Imports.create(
          imports: [
            useCaseType,
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
        usecase.writeln('late $responseType success;');
        usecase.writeln('late Failure failure;');
        usecase.writeln('setUp(() {');
        usecase.writeln('repository = Mock$repositoryName();');
        usecase.writeln('$useCaseName = $useCaseType(repository);');
        usecase.writeln("failure = Failure(1, 'message');");
        final model = names.camelCaseToUnderscore(names.baseModelName(type));
        final decode =
            "jsonDecode(File('test/expected/expected_$model.json').readAsStringSync())";
        if (responseType.contains('List')) {
          usecase.writeln("success = List.generate(");
          usecase.writeln("2,");
          usecase.writeln("(index) =>");
          usecase.writeln("$modelType.fromJson($decode),");
          usecase.writeln(");");
        } else {
          usecase.writeln("success = $modelType.fromJson($decode);");
        }

        usecase.writeln("});\n");
        usecase.writeln("webService() => repository.$methodName();\n");
        usecase.writeln("group('$useCaseType ', () {");
        usecase.writeln("test('$methodName FAILURE', ()  {");
        usecase.writeln(
            "when(webService()).thenAnswer((realInvocation) => Left(failure));");
        usecase.writeln("final res = $useCaseName.execute();");
        usecase.writeln("expect(res.left((data) {}), failure);");
        usecase.writeln("verify(webService());");
        usecase.writeln("verifyNoMoreInteractions(repository);");
        usecase.writeln("});\n\n");
        usecase.writeln("test('$methodName SUCCESS', () {");
        usecase.writeln(
            "when(webService()).thenAnswer((realInvocation) => Right(success));");
        usecase.writeln("final res = $useCaseName.execute();");
        usecase.writeln("expect(res.right((data) {}), success);");
        usecase.writeln("verify(webService());");
        usecase.writeln("verifyNoMoreInteractions(repository);");
        usecase.writeln("});");
        usecase.writeln("});");
        usecase.writeln("}");

        AddFile.save("$path/$fileName", usecase.toString());
        classBuffer.writeln(usecase);
      }
    }
    return classBuffer.toString();
  }
}
