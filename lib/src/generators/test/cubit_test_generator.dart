import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/annotations.dart';
import 'package:clean_architecture_generator/src/imports_file.dart';
import 'package:source_gen/source_gen.dart';

import '../../add_file_to_project.dart';
import '../../model_visitor.dart';

class CubitTestGenerator
    extends GeneratorForAnnotation<ArchitectureTDDAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final basePath = AddFile.getDirectories(buildStep.inputId.path)
        .replaceFirst('lib', 'test');
    final path = "$basePath/presentation/logic";
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    final methodFormat = MethodFormat();
    final names = Names();
    for (var method in visitor.useCases) {
      final methodName = method.name;
      final hasRequest = method.parameters.isNotEmpty;
      final hasTextControllers = method.textControllers.isNotEmpty;
      final useCaseName = names.useCaseName(methodName);
      final useCaseType = names.useCaseType(methodName);
      final cubitType = names.cubitType(methodName);
      final fileName = "${names.camelCaseToUnderscore(cubitType)}_test";
      final returnType = methodFormat.returnType(method.type);
      final modelType = names.ModelType(returnType);
      final modelRuntimeType = names.modelRuntimeType(modelType);
      List<ParameterElement> parameters = method.parameters;
      String request = "";

      if (hasTextControllers) {
        parameters.removeWhere((item) {
          final index = method.emitSets
              .indexWhere((element) => element.name == item.name);
          return index != -1;
        });
        parameters.removeWhere((item) {
          final index = method.textControllers
              .indexWhere((element) => element.name == item.name);
          return index != -1;
        });
        parameters.removeWhere((item) {
          final index = method.functionSets
              .indexWhere((element) => element.name == item.name);
          return index != -1;
        });
      }

      String requestType = '';
      if (hasRequest) {
        requestType = names.requestType(methodName);
      }
      final cubit = StringBuffer();

      cubit.writeln(
        Imports.create(
          filePath: buildStep.inputId.path,
          imports: [
            cubitType,
            useCaseType,
            requestType,
            "base_response",
            "state_renderer",
            "states",
            "failure",
          ],
          libs: [
            "import 'dart:io';",
            "import 'dart:convert';",
            hasTextControllers ? "import 'package:flutter/material.dart';" : "",
            "import 'package:bloc_test/bloc_test.dart';",
            "import 'package:eitherx/eitherx.dart';",
            "import 'package:flutter_test/flutter_test.dart';",
            "import 'package:mockito/annotations.dart';",
            "import 'package:mockito/mockito.dart';",
            "import '$fileName.mocks.dart';",
          ],
        ),
      );
      cubit.writeln(" @GenerateNiceMocks([");
      if (hasTextControllers) {
        cubit.writeln("   MockSpec<TextEditingController>(),");
        cubit.writeln("   MockSpec<GlobalKey<FormState>>(),");
        cubit.writeln("   MockSpec<FormState>(),");
      }
      cubit.writeln("   MockSpec<$useCaseType>(),");
      cubit.writeln(" ])");
      cubit.writeln(" void main() {");
      cubit.writeln("   late $cubitType cubit;");
      cubit.writeln("   late $useCaseType $useCaseName;");
      for (var con in method.textControllers) {
        cubit.writeln("   late TextEditingController ${con.name};");
      }
      if (hasTextControllers) {
        cubit.writeln("   late GlobalKey<FormState> key;");
        cubit.writeln("   late FormState formState;");
      }
      if (hasRequest) {
        cubit.writeln("   late $requestType request;");
      }
      cubit.writeln("   late $returnType response;");
      cubit.writeln("   late Failure failure;");
      cubit.writeln("   setUp(() async {");
      for (var con in method.textControllers) {
        cubit.writeln("     ${con.name} = MockTextEditingController();");
      }
      if (hasTextControllers) {
        cubit.writeln("     key = MockGlobalKey();");
        cubit.writeln("     formState = MockFormState();");
      }
      cubit.writeln("     $useCaseName = Mock$useCaseType();");
      if (hasRequest) {
        cubit.writeln(
            "     request = $requestType(${methodFormat.parametersWithValues(method.parameters)});");
        request = "request : request";
      }
      cubit.writeln("///[${names.firstUpper(methodName)}]");
      cubit.writeln('response = $returnType(');
      cubit.writeln("message: 'message',");
      cubit.writeln("success: true,");
      if (modelRuntimeType == 'int' ||
          modelRuntimeType == 'double' ||
          modelRuntimeType == 'num' ||
          modelRuntimeType == 'String' ||
          modelRuntimeType == 'Map' ||
          modelRuntimeType == 'bool') {
        cubit.writeln(
            "data: ${methodFormat.initData(modelRuntimeType, 'name')},);");
      } else if (returnType.contains('BaseResponse<dynamic>')) {
        cubit.writeln("data: null,);");
      } else {
        final model = names.camelCaseToUnderscore(names.ModelType(returnType));
        AddFile.save(
          "test/expected/expected_$model",
          '{}',
          extension: 'json',
        );
        final decode = "fromJson('expected_$model')";
        if (returnType.contains('List')) {
          cubit.writeln("data: List.generate(");
          cubit.writeln("2,");
          cubit.writeln("(index) =>");
          cubit.writeln("$modelType.fromJson($decode),");
          cubit.writeln("));");
        } else {
          cubit.writeln("data: $modelType.fromJson($decode),);");
        }
      }
      cubit.writeln("     failure = Failure(1, '');");
      if (hasTextControllers) {
        cubit.writeln("     cubit = $cubitType(");
        cubit.writeln("     $useCaseName,");
        cubit.writeln("     key,");
        if (hasRequest) cubit.writeln("     request,");
        for (var con in method.textControllers) {
          cubit.writeln("     ${con.name},");
        }
        cubit.writeln("     );");
      } else {
        cubit.writeln("     cubit = $cubitType($useCaseName,");
        if (hasRequest) cubit.writeln("     request,");
        cubit.writeln("     );");
      }
      cubit.writeln("   });");
      cubit.writeln(" group('$cubitType CUBIT', () {");
      if (method.isPaging) {
        cubit.writeln("     blocTest<$cubitType, FlowState>(");
        cubit.writeln("       '$methodName failure METHOD',");
        cubit.writeln("       build: () => cubit,");
        cubit.writeln("       act: (cubit) {");
        cubit.writeln("         when($useCaseName.execute($request))");
        cubit.writeln(
            "             .thenAnswer((realInvocation) async => Left(failure));");
        cubit.writeln(
            "         cubit.execute(${methodFormat.parametersWithValues(parameters)});");
        cubit.writeln("       },");
        cubit.writeln("       expect: () => <FlowState>[");
        cubit.writeln("         ErrorState(");
        cubit.writeln("           type: StateRendererType.toastError,");
        cubit.writeln("           message: failure.message,");
        cubit.writeln("         )");
        cubit.writeln("       ],");
        cubit.writeln("     );");
        cubit.writeln("     blocTest<$cubitType, FlowState>(");
        cubit.writeln("       '$methodName success METHOD',");
        cubit.writeln("       build: () => cubit,");
        cubit.writeln("       act: (cubit) {");
        cubit.writeln("         when($useCaseName.execute($request))");
        cubit.writeln(
            "             .thenAnswer((realInvocation) async => Right(response));");
        cubit.writeln("         cubit.init();");
        cubit.writeln(
            "         cubit.execute(${methodFormat.parametersWithValues(parameters)});");
        cubit.writeln("       },");
        cubit.writeln("       expect: () => <FlowState>[],");
        cubit.writeln("     );");
      } else {
        if (hasTextControllers) {
          cubit.writeln("     blocTest<$cubitType, FlowState>(");
          cubit.writeln("       '$methodName validation error METHOD',");
          cubit.writeln("       build: () => cubit,");
          cubit.writeln("       act: (cubit) {");
          cubit.writeln(
              "         when(key.currentState).thenAnswer((realInvocation) => formState);");
          cubit.writeln(
              "         when(formState.validate()).thenAnswer((realInvocation) => false);");
          cubit.writeln(
              "         cubit.execute(${methodFormat.parametersWithValues(parameters)});");
          cubit.writeln("       },");
          cubit.writeln("       expect: () => <FlowState>[],");
          cubit.writeln("     );\n");
        }
        for (var fun in method.emitSets) {
          cubit.writeln("     blocTest<$cubitType, FlowState>(");
          cubit.writeln("       'set${names.firstUpper(fun.name)}',");
          cubit.writeln("       build: () => cubit,");
          cubit.writeln("       act: (cubit) {");
          cubit.writeln(
              "         cubit.set${names.firstUpper(fun.name)}(${methodFormat.initData(fun.type, fun.name)});");
          cubit.writeln("       },");
          cubit.writeln("       expect: () => <FlowState>[");
          cubit.writeln("         ContentState(),");
          cubit.writeln("       ],");
          cubit.writeln("     );\n");
        }

        cubit.writeln("     blocTest<$cubitType, FlowState>(");
        cubit.writeln("       '$methodName success true status METHOD',");
        cubit.writeln("       build: () => cubit,");
        cubit.writeln("       act: (cubit) {");
        if (hasTextControllers) {
          cubit.writeln(
              "         when(key.currentState).thenAnswer((realInvocation) => formState);");
          cubit.writeln(
              "         when(formState.validate()).thenAnswer((realInvocation) => true);");
        }
        for (var con in method.textControllers) {
          cubit.writeln(
              "         when(${con.name}.text).thenAnswer((realInvocation) => ${methodFormat.initData(con.type, con.name)});");
        }
        cubit.writeln("         when($useCaseName.execute($request))");
        cubit.writeln(
            "             .thenAnswer((realInvocation) async => Right(response));");
        if (method.emitSets.isNotEmpty) {
          for (var fun in method.emitSets) {
            cubit.writeln(
                "         cubit.set${names.firstUpper(fun.name)}(${methodFormat.initData(fun.type, fun.name)});");
          }
        } else {
          for (var fun in method.functionSets) {
            cubit.writeln(
                "         cubit.set${names.firstUpper(fun.name)}(${methodFormat.initData(fun.type, fun.name)});");
          }
        }
        cubit.writeln(
            "         cubit.execute(${methodFormat.parametersWithValues(parameters)});");
        cubit.writeln("       },");
        cubit.writeln("       expect: () => <FlowState>[");
        if (method.emitSets.isNotEmpty) {
          cubit.writeln("         ContentState(),");
        }
        cubit.writeln(
            "         LoadingState(type: StateRendererType.popUpLoading),");
        cubit.writeln(
            "         SuccessState(message: 'message', type: StateRendererType.contentState)");
        cubit.writeln("       ],");
        cubit.writeln("     );");
        cubit.writeln("     blocTest<$cubitType, FlowState>(");
        cubit.writeln("       '$methodName success false status METHOD',");
        cubit.writeln("       build: () => cubit,");
        cubit.writeln("       act: (cubit) {");
        if (hasTextControllers) {
          cubit.writeln(
              "         when(key.currentState).thenAnswer((realInvocation) => formState);");
          cubit.writeln(
              "         when(formState.validate()).thenAnswer((realInvocation) => true);");
        }
        for (var con in method.textControllers) {
          cubit.writeln(
              "         when(${con.name}.text).thenAnswer((realInvocation) => ${methodFormat.initData(con.type, con.name)});");
        }
        cubit.writeln(
            "         when($useCaseName.execute($request)).thenAnswer(");
        cubit.writeln(
            "                 (realInvocation) async => Right(response..success = false));");
        if (method.emitSets.isNotEmpty) {
          for (var fun in method.emitSets) {
            cubit.writeln(
                "         cubit.set${names.firstUpper(fun.name)}(${methodFormat.initData(fun.type, fun.name)});");
          }
        } else {
          for (var fun in method.functionSets) {
            cubit.writeln(
                "         cubit.set${names.firstUpper(fun.name)}(${methodFormat.initData(fun.type, fun.name)});");
          }
        }

        cubit.writeln(
            "         cubit.execute(${methodFormat.parametersWithValues(parameters)});");
        cubit.writeln("       },");
        cubit.writeln("       expect: () => <FlowState>[");
        if (method.emitSets.isNotEmpty) {
          cubit.writeln("         ContentState(),");
        }
        cubit.writeln(
            "         LoadingState(type: StateRendererType.popUpLoading),");
        cubit.writeln(
            "         ErrorState(type: StateRendererType.toastError, message: 'message')");
        cubit.writeln("       ],");
        cubit.writeln("     );\n");
        cubit.writeln("   blocTest<$cubitType, FlowState>(");
        cubit.writeln("     '$methodName failure METHOD',");
        cubit.writeln("     build: () => cubit,");
        cubit.writeln("     act: (cubit) {");
        if (hasTextControllers) {
          cubit.writeln(
              "       when(key.currentState).thenAnswer((realInvocation) => formState);");
          cubit.writeln(
              "       when(formState.validate()).thenAnswer((realInvocation) => true);");
        }
        for (var con in method.textControllers) {
          cubit.writeln(
              "         when(${con.name}.text).thenAnswer((realInvocation) => ${methodFormat.initData(con.type, con.name)});");
        }

        cubit.writeln("       when($useCaseName.execute($request))");
        cubit.writeln(
            "           .thenAnswer((realInvocation) async => Left(failure));");
        if (method.emitSets.isNotEmpty) {
          for (var fun in method.emitSets) {
            cubit.writeln(
                "         cubit.set${names.firstUpper(fun.name)}(${methodFormat.initData(fun.type, fun.name)});");
          }
        } else {
          for (var fun in method.functionSets) {
            cubit.writeln(
                "         cubit.set${names.firstUpper(fun.name)}(${methodFormat.initData(fun.type, fun.name)});");
          }
        }

        cubit.writeln(
            "       cubit.execute(${methodFormat.parametersWithValues(parameters)});");
        cubit.writeln("     },");
        cubit.writeln("     expect: () => <FlowState>[");
        if (method.emitSets.isNotEmpty) {
          cubit.writeln("         ContentState(),");
        }
        cubit.writeln(
            "       LoadingState(type: StateRendererType.popUpLoading),");
        cubit.writeln(
            "       ErrorState(type: StateRendererType.toastError, message: failure.message)");
        cubit.writeln("     ],");
        cubit.writeln("   );");
      }
      cubit.writeln("   });");

      cubit.writeln(" }");

      cubit.writeln("///[FromJson]");
      cubit.writeln("Map<String, dynamic> fromJson(String path) {");
      cubit.writeln(
          " return jsonDecode(File('test/expected/\$path.json').readAsStringSync());");
      cubit.writeln("}");

      AddFile.save('$path/$fileName', cubit.toString());
    }

    return '';
  }
}
