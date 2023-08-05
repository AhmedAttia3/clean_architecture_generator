import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/annotations.dart';
import 'package:clean_architecture_generator/src/imports_file.dart';
import 'package:source_gen/source_gen.dart';

import '../model_visitor.dart';

class CubitGenerator extends GeneratorForAnnotation<ArchitectureAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final path =
        "${AddFile.getDirectories(buildStep.inputId.path)}/presentation/logic";
    final visitor = ModelVisitor();

    final methodFormat = MethodFormat();
    element.visitChildren(visitor);

    final cubits = StringBuffer();

    for (var method in visitor.useCases) {
      final cubit = StringBuffer();
      final varName = names.subName(method.name);
      final hasParams = method.parameters.isNotEmpty;
      final cubitType = names.cubitType(method.name);
      final useCaseType = names.useCaseType(method.name);
      final requestType = names.requestType(method.name);
      final type = methodFormat.returnType(method.type);
      final responseType = methodFormat.responseType(type);
      final baseModelType = names.ModelType(type);
      final hasData = !type.contains('BaseResponse<dynamic>');
      final hasTextController = method.textControllers.isNotEmpty;
      final hasFunctionSet = method.functionSets.isNotEmpty;
      final hasEmitSet = method.emitSets.isNotEmpty;

      ///[Imports]
      cubit.writeln(Imports.create(
        imports: [useCaseType, hasParams ? requestType : ""],
        filePath: buildStep.inputId.path,
        isCubit: true,
        isPaging: method.isPaging,
      ));
      cubit.writeln('///[$cubitType]');
      cubit.writeln('///[Implementation]');
      cubit.writeln('@injectable');
      cubit.writeln('class $cubitType extends Cubit<FlowState> {');
      cubit.writeln('final $useCaseType _${names.firstLower(useCaseType)};');
      if (hasParams) cubit.writeln('final $requestType request;');
      if (method.isPaging) {
        cubit.writeln(
            'late final PagewiseLoadController<$baseModelType> pagewiseController;');
        cubit.writeln('$cubitType(this._${names.firstLower(useCaseType)},');
        if (hasParams) cubit.writeln('this.request,');
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
            'Future<$responseType> execute(${methodFormat.parameters(method.parameters)}) async {');
        cubit.writeln('$responseType $varName = [];');
        for (var parma in method.parameters) {
          cubit.writeln('request.${parma.name} = ${parma.name};');
        }
        cubit.writeln(
            'final res = await _${names.firstLower(useCaseType)}.execute(');
        if (hasParams) {
          cubit.writeln("request : request");
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

        ///[initialize formKey for validation]
        if (hasParams) {
          cubit.writeln('final $requestType request;');
        }

        ///[initialize controller for TextEditingController]
        for (var controller in method.textControllers) {
          cubit.writeln('final TextEditingController ${controller.name};');
          method.parameters
              .removeWhere((element) => controller.name == element.name);
        }

        ///[initialize constructor]
        cubit.writeln('$cubitType(this._${names.firstLower(useCaseType)},');
        if (hasTextController) cubit.writeln('this.formKey,');
        if (hasParams) cubit.writeln('this.request,');
        for (var controller in method.textControllers) {
          cubit.writeln('this.${controller.name},');
        }
        cubit.writeln(') : super(ContentState());\n');

        ///[initialize var for data when cubit is get request]
        if (hasData) {
          if (responseType.contains('List')) {
            cubit.writeln('$responseType $varName = [];');
          } else {
            cubit.writeln('$responseType? $varName;');
          }
        }
        if (hasEmitSet) {
          ///[initialize variable for set emit function]
          for (var function in method.emitSets) {
            cubit.write('${function.type} ${function.name}');
            cubit.write(initVaType(function.type));
            method.parameters
                .removeWhere((element) => function.name == element.name);
          }
        } else if (hasFunctionSet) {
          ///[initialize variable for set function]
          for (var function in method.functionSets) {
            cubit.write('${function.type} ${function.name}');
            cubit.write(initVaType(function.type));
            method.parameters
                .removeWhere((element) => function.name == element.name);
          }
        }

        cubit.writeln('\n');
        cubit.writeln(
            'Future<void> execute(${methodFormat.parameters(method.parameters)}) async {');
        if (hasTextController) {
          cubit.writeln('if (formKey.currentState!.validate()) {');
        }

        ///[add textEditController to request]
        if (hasTextController) {
          for (var controller in method.textControllers) {
            cubit.writeln('request.${controller.name} =');
            if (controller.type == 'int') {
              cubit.writeln('int.parse(${controller.name}.text);');
            } else if (controller.type == 'double') {
              cubit.writeln('double.parse(${controller.name}.text);');
            } else if (controller.type == 'num') {
              cubit.writeln('num.parse(${controller.name}.text);');
            } else {
              cubit.writeln('${controller.name}.text;');
            }
          }
        }

        if (hasEmitSet) {
          ///[add variables to request]
          for (var function in method.emitSets) {
            cubit.writeln('request.${function.name} = ${function.name};');
          }
        } else if (hasFunctionSet) {
          ///[add variables to request]
          for (var function in method.functionSets) {
            cubit.writeln('request.${function.name} = ${function.name};');
          }
        }

        ///[add params to request]
        for (var parma in method.parameters) {
          cubit.writeln('request.${parma.name} = ${parma.name};');
        }

        cubit.writeln(
            'emit(LoadingState(type: StateRendererType.popUpLoading));');
        cubit.writeln(
            'final res = await _${names.firstLower(useCaseType)}.execute(');

        ///[add request]
        if (hasParams || hasTextController || hasFunctionSet || hasEmitSet) {
          cubit.writeln("request : request");
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

        if (hasEmitSet) {
          ///[create emit set]
          for (var function in method.emitSets) {
            cubit.writeln(
                'void set${names.firstUpper(function.name)}(${function.type} value){');
            cubit.writeln('${function.name} = value;');
            cubit.writeln('emit(ContentState());');
            cubit.writeln('}');
          }
        } else if (hasFunctionSet) {
          ///[create set function]
          for (var function in method.functionSets) {
            cubit.writeln(
                'void set${names.firstUpper(function.name)}(${function.type} value){');
            cubit.writeln('${function.name} = value;');
            cubit.writeln('}');
          }
        }

        cubit.writeln('}');
      }

      AddFile.save('$path/$cubitType', cubit.toString());
      cubits.writeln(cubit);
    }
    return cubits.toString();
  }

  String initVaType(String type) {
    switch (type) {
      case 'String':
        return ' = "";';
      case 'double':
        return ' = 0.0;';
      case 'int':
        return ' = 0;';
      case 'List':
        return ' = [];';
      case 'num':
        return ' = 0;';
      default:
        return "\n";
    }
  }
}
