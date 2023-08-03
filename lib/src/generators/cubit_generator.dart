import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:mvvm_generator/formatter/method_format.dart';
import 'package:mvvm_generator/formatter/names.dart';
import 'package:mvvm_generator/src/add_file_to_project.dart';
import 'package:mvvm_generator/src/mvvm_generator_annotations.dart';
import 'package:mvvm_generator/src/read_imports_file.dart';
import 'package:source_gen/source_gen.dart';

import '../model_visitor.dart';

class CubitGenerator extends GeneratorForAnnotation<MVVMAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final path = "${AddFile.path(buildStep.inputId.path)}/logic";
    final visitor = ModelVisitor();

    final methodFormat = MethodFormat();
    element.visitChildren(visitor);

    final cubits = StringBuffer();

    for (var method in visitor.useCases) {
      final cubit = StringBuffer();
      final varName = names.subName(method.name);
      final hasParams = method.parameters.isNotEmpty;
      final cubitName = '${names.firstUpper(method.name)}Cubit';
      final useCaseName = '${names.firstUpper(method.name)}UseCase';
      final requestName = '${names.firstUpper(method.name)}Request';
      final type = methodFormat.returnType(method.type);
      final responseDataType = names.responseDataType(type);
      final baseModelType = names.baseModelName(type);
      final hasData = !type.contains('BaseResponse<dynamic>');
      final hasTextController = method.textControllers.isNotEmpty;
      final hasFunctionSet = method.functionSets.isNotEmpty;

      ///[Imports]
      cubit.writeln(Imports.create(
        imports: [useCaseName, hasParams ? requestName : ""],
        filePath: buildStep.inputId.path,
        isCubit: true,
        isPaging: method.isPaging,
      ));
      cubit.writeln('///[$cubitName]');
      cubit.writeln('///[Implementation]');
      cubit.writeln('@injectable');
      cubit.writeln('class $cubitName extends Cubit<FlowState> {');
      cubit.writeln('final $useCaseName _${names.firstLower(useCaseName)};');
      if (method.isPaging) {
        cubit.writeln(
            'late final PagewiseLoadController<$baseModelType> pagewiseController;');
        cubit.writeln('$cubitName(this._${names.firstLower(useCaseName)},');
        cubit.writeln(') : super(ContentState());');
        cubit.writeln('void init() {');
        cubit.writeln(
            'pagewiseController = PagewiseLoadController<$baseModelType>(');
        cubit.writeln('pageSize: 10,');
        cubit.writeln('pageFuture: (page) {');
        cubit.writeln('final offset = page ?? 0;');
        cubit.writeln('return execute(page: offset, limit: offset * 10);');
        cubit.writeln('},');
        cubit.writeln(');');
        cubit.writeln('}');
        cubit.writeln(
            'Future<$responseDataType> execute(${methodFormat.parameters(method.parameters)}) async {');
        cubit.writeln('$responseDataType $varName = [];');
        cubit.writeln(
            'final res = await _${names.firstLower(useCaseName)}.execute(');
        if (hasParams) {
          cubit.writeln(
              "request : $requestName(${methodFormat.passingParameters(method.parameters)}),");
        }
        cubit.writeln(');');
        cubit.writeln('res.left((failure) {');
        cubit.writeln('emit(ErrorState(');
        cubit.writeln('type: StateRendererType.toastError,');
        cubit.writeln('message: failure.message,');
        cubit.writeln('));');
        cubit.writeln('});');
        cubit.writeln('res.right((data) {');
        if (hasData) {
          cubit.writeln('if(data.data != null){');
          cubit.writeln('$varName = data.data!;');
          cubit.writeln('}');
        }
        cubit.writeln('});');
        cubit.writeln('return $varName;');
        cubit.writeln('}');
        cubit.writeln('}');
      } else {
        ///[initialize formKey for validation]
        if (hasTextController) {
          cubit.writeln('final GlobalKey<FormState> formKey;');
        }

        ///[initialize controller for TextEditingController]
        for (var controller in method.textControllers) {
          cubit.writeln('final TextEditingController ${controller.name};');
          method.parameters
              .removeWhere((element) => controller.name == element.name);
        }

        ///[initialize constructor]
        cubit.writeln('$cubitName(this._${names.firstLower(useCaseName)},');
        if (hasTextController) cubit.writeln('this.formKey,');
        for (var controller in method.textControllers) {
          cubit.writeln('this.${controller.name},');
        }
        cubit.writeln(') : super(ContentState());\n');

        ///[initialize var for data when cubit is get request]
        if (hasData) {
          if (responseDataType.contains('List')) {
            cubit.writeln('$responseDataType $varName = [];');
          } else {
            cubit.writeln('$responseDataType? $varName;');
          }
        }

        ///[initialize variable for set function]
        for (var function in method.functionSets) {
          cubit.write('${function.type} ${function.name}');
          switch (function.type) {
            case 'String':
              cubit.write(' = "";');
              break;
            case 'double':
              cubit.write(' = 0.0;');
              break;
            case 'int':
              cubit.write(' = 0;');
              break;
            case 'List':
              cubit.write(' = [];');
              break;
            case 'num':
              cubit.write(' = 0;');
              break;
          }
          method.parameters
              .removeWhere((element) => function.name == element.name);
        }

        cubit.writeln('\n');
        cubit.writeln(
            'Future<void> execute(${methodFormat.parameters(method.parameters)}) async {');
        if (hasTextController) {
          cubit.writeln('if (formKey.currentState!.validate()) {');
        }
        cubit.writeln(
            'emit(LoadingState(type: StateRendererType.popUpLoading));');
        cubit.writeln(
            'final res = await _${names.firstLower(useCaseName)}.execute(');

        ///[add request]
        if (hasParams || hasTextController || hasFunctionSet) {
          cubit.writeln("request : $requestName(");
        }

        ///[add textEditController to request]
        if (hasTextController) {
          for (var controller in method.textControllers) {
            cubit.writeln('${controller.name} :');
            if (controller.type == 'int') {
              cubit.writeln('int.parse(${controller.name}.text),');
            } else if (controller.type == 'double') {
              cubit.writeln('double.parse(${controller.name}.text),');
            } else if (controller.type == 'num') {
              cubit.writeln('num.parse(${controller.name}.text),');
            } else {
              cubit.writeln('${controller.name}.text,');
            }
          }
        }

        ///[add variables to request]
        if (hasFunctionSet) {
          for (var function in method.functionSets) {
            cubit.writeln('${function.name} : ${function.name},');
          }
        }

        ///[add params to request]
        if (hasParams) {
          cubit.writeln(methodFormat.passingParameters(method.parameters));
        }

        ///[add end of request params]
        if (hasParams || hasTextController || hasFunctionSet) {
          cubit.writeln("),");
        }
        cubit.writeln(');');
        cubit.writeln('res.left((failure) {');
        cubit.writeln('emit(ErrorState(');
        cubit.writeln('type: StateRendererType.toastError,');
        cubit.writeln('message: failure.message,');
        cubit.writeln('));');
        cubit.writeln('});');
        cubit.writeln('res.right((data) {');
        cubit.writeln('if (data.success) {');
        if (hasData) {
          cubit.writeln('if(data.data != null){');
          cubit.writeln('$varName = data.data!;');
          cubit.writeln('}');
        }
        cubit.writeln('emit(SuccessState(');
        cubit.writeln('message: data.message,');
        cubit.writeln('type: StateRendererType.contentState,');
        cubit.writeln('));');
        cubit.writeln('} else {');
        cubit.writeln('emit(SuccessState(');
        cubit.writeln('message: data.message,');
        cubit.writeln('type: StateRendererType.toastError,');
        cubit.writeln('));');
        cubit.writeln('}');
        cubit.writeln('});');
        cubit.writeln('}');

        if (hasTextController) cubit.writeln('}');

        ///[create set function]
        for (var function in method.functionSets) {
          cubit.writeln(
              'void set${names.firstUpper(function.name)}(${function.type} value){');
          cubit.writeln('${function.name} = value;');
          cubit.writeln('}');
        }

        cubit.writeln('}');
      }

      AddFile.save('$path/$cubitName', cubit.toString());
      cubits.writeln(cubit);
    }
    return cubits.toString();
  }
}
