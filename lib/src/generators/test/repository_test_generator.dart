import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:generators/formatter/method_format.dart';
import 'package:generators/formatter/names.dart';
import 'package:generators/src/add_file_to_project.dart';
import 'package:generators/src/mvvm_generator_annotations.dart';
import 'package:generators/src/read_imports_file.dart';
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
    final basePath =
        AddFile.path(buildStep.inputId.path).replaceFirst('lib', 'test');
    final visitor = ModelVisitor();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);
    final classBuffer = StringBuffer();

    final remoteDataSourceType = names.firstUpper(visitor.className);
    final repositoryType = '${remoteDataSourceType}Repository';
    final repositoryImplementType = '${remoteDataSourceType}RepositoryImpl';
    final fileName = "${names.camelCaseToUnderscore(repositoryType)}_test";
    classBuffer.writeln(ReadImports.imports(
      filePath: buildStep.inputId.path,
      isTest: true,
    ));
    for (var method in visitor.useCases) {
      if (method.parameters.isEmpty) {
        continue;
      }
      final requestName = names
          .camelCaseToUnderscore('${names.firstUpper(method.name)}Request');
      classBuffer.writeln("import '../requests/$requestName.dart';");
    }
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
    classBuffer.writeln('late Failure failure;');

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
    classBuffer.writeln("failure = Failure(1, 'message');");

    for (var method in visitor.useCases) {
      final methodName = method.name;
      final type = methodFormat.returnType(method.type);
      classBuffer.writeln("///[${names.firstUpper(methodName)}]");
      classBuffer.writeln('${methodName}Response = $type(');
      classBuffer.writeln("message: 'message',");
      classBuffer.writeln("success: true,");
      if (type.contains('BaseResponse<dynamic>')) {
        classBuffer.writeln("data: null,);");
      } else {
        final model = names.baseModelName(type);
        final expectedModel = "expected_${names.camelCaseToUnderscore(model)}";
        AddFile.save(
          "$basePath/expected/$expectedModel",
          '{}',
          extension: 'json',
        );
        if (type.contains('List')) {
          classBuffer.writeln("data: List.generate(");
          classBuffer.writeln("2,");
          classBuffer.writeln("(index) =>");
          classBuffer
              .writeln("$model.fromJson(Encode.set('$expectedModel'))),");
          classBuffer.writeln(");");
          classBuffer.writeln("});");
        } else {
          classBuffer.writeln(
              "data: $model.fromJson(Encode.set('$expectedModel')),);");
        }
      }
    }
    classBuffer.writeln('});');

    for (var method in visitor.useCases) {
      final methodName = method.name;
      classBuffer.writeln(
          "$methodName() => dataSource.$methodName(${methodFormat.parametersWithValues(method.parameters)});");
    }

    classBuffer.writeln("group('$repositoryType Repository', () {");
    if (visitor.useCases.isNotEmpty) {
      classBuffer.writeln("test('No Internet', () async {");
      classBuffer.writeln(
          "when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);");
      final method = visitor.useCases.first;
      final requestName = '${names.firstUpper(method.name)}Request';
      if (method.parameters.isNotEmpty) {
        final request =
            "$requestName(${methodFormat.parametersWithValues(method.parameters)})";
        classBuffer.writeln(
            "final res = await repository.${method.name}(request: $request);");
      } else {
        classBuffer.writeln("final res = await repository.${method.name}();");
      }
      classBuffer.writeln("expect(res.left((data) {}), isA<Failure>());");
      classBuffer.writeln("verify(networkInfo.isConnected);");
      classBuffer.writeln("verifyNoMoreInteractions(networkInfo);");
      classBuffer.writeln("});");

      for (var method in visitor.useCases) {
        final methodName = method.name;
        final requestName = '${names.firstUpper(method.name)}Request';
        classBuffer.writeln("test('$methodName', () async {");
        classBuffer.writeln(
            "when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);");
        classBuffer.writeln("when($methodName())");
        classBuffer.writeln(
            ".thenAnswer((realInvocation) async => ${methodName}Response);");
        if (method.parameters.isNotEmpty) {
          final request =
              "$requestName(${methodFormat.parametersWithValues(method.parameters)})";
          classBuffer.writeln(
              "final res = await repository.$methodName(request: $request);");
        } else {
          classBuffer.writeln("final res = await repository.$methodName();");
        }
        classBuffer
            .writeln("expect(res.right((data) {}), ${methodName}Response);");
        classBuffer.writeln("verify(networkInfo.isConnected);");
        classBuffer.writeln("verify(getSettings());");
        classBuffer.writeln("verifyNoMoreInteractions(networkInfo);");
        classBuffer.writeln("verifyNoMoreInteractions(dataSource);");
        classBuffer.writeln("});");
      }
    }
    classBuffer.writeln("});");
    classBuffer.writeln("}");

    AddFile.save(
        '$basePath/repository/${repositoryType}Test', classBuffer.toString());
    return classBuffer.toString();
  }
}
