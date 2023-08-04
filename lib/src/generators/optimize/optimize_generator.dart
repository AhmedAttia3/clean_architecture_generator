import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/annotations.dart';
import 'package:clean_architecture_generator/src/model_visitor.dart';
import 'package:clean_architecture_generator/src/read_imports_file.dart';
import 'package:source_gen/source_gen.dart';

class OptimizeGenerator extends GeneratorForAnnotation<ArchitectureAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final path = "/lib/core";
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    ///[BaseUseCase]
    final baseUseCase = StringBuffer();
    baseUseCase.writeln('///[BaseUseCase]');
    baseUseCase.writeln('///[Implementation]');
    baseUseCase.writeln("import 'package:eitherx/eitherx.dart';");
    baseUseCase.writeln("abstract class BaseUseCase<RES, POS> {");
    baseUseCase.writeln("RES execute({POS? request});");
    baseUseCase.writeln("}");

    AddFile.save('$path/base_use_case', baseUseCase.toString());

    ///[Failure]
    final failure = StringBuffer();
    failure.writeln('///[Failure]');
    failure.writeln('///[Implementation]');
    failure.writeln("class Failure {");
    failure.writeln("int code; // 200, 201, 400, 303..500 and so on");
    failure.writeln("String message; // error , success\n");
    failure.writeln("Failure(this.code, this.message);");
    failure.writeln("}");

    AddFile.save('$path/failure', failure.toString());

    ///[StateRendererType]
    final stateRenderer = StringBuffer();
    stateRenderer.writeln("enum StateRendererType {");
    stateRenderer.writeln("popUpLoading,");
    stateRenderer.writeln("popUpError,");
    stateRenderer.writeln("toastError,");
    stateRenderer.writeln("toastSuccess,");
    stateRenderer.writeln("fullScreenLoading,");
    stateRenderer.writeln("fullScreenSuccess,");
    stateRenderer.writeln("fullScreenError,");
    stateRenderer.writeln("fullScreenEmpty,");
    stateRenderer.writeln("contentState");
    stateRenderer.writeln("}");

    AddFile.searchAndAddFile('$path/stateRenderer', stateRenderer.toString());

    ///[States]
    final states = StringBuffer();
    states.writeln(Imports.create(
      filePath: buildStep.inputId.path,
      imports: [
        "StateRenderer",
      ],
    ));
    states.writeln("abstract class FlowState extends Equatable {");
    states.writeln("StateRendererType getStateRendererType();");
    states.writeln("String getMessage();");
    states.writeln("}\n\n");

    states.writeln("class InitialState extends FlowState {");
    states.writeln("@override");
    states.writeln("String getMessage() {");
    states.writeln("return '';");
    states.writeln("}");
    states.writeln("@override");
    states.writeln(
        "StateRendererType getStateRendererType() => StateRendererType.contentState;");
    states.writeln("List<Object?> get props => [];");
    states.writeln("}\n\n");

    for (var state in ["Loading", "Error", "Empty"]) {
      states.writeln("class ${state}State extends FlowState {");
      states.writeln("final StateRendererType type;");
      states.writeln("final String? message;");
      states.writeln("${state}State({");
      states.writeln("required this.type,");
      states.writeln("this.message,");
      states.writeln("});");
      states.writeln("@override");
      states.writeln("String getMessage() => message ?? '';");
      states.writeln("@override");
      states.writeln("StateRendererType getStateRendererType() => type;");
      states.writeln("List<Object?> get props => [type, message];");
      states.writeln("}\n\n");
    }

    states.writeln("class SuccessState<T> extends FlowState {");
    states.writeln("final StateRendererType type;");
    states.writeln("final String message;");
    states.writeln("final T? data;");
    states.writeln("SuccessState({");
    states.writeln("required this.type,");
    states.writeln("required this.message,");
    states.writeln("this.data,");
    states.writeln("});");
    states.writeln("@override");
    states.writeln("String getMessage() => message ?? '';");
    states.writeln("@override");
    states.writeln("StateRendererType getStateRendererType() => type;");
    states.writeln("List<Object?> get props => [type, message];");
    states.writeln("}\n\n");

    states.writeln("class ContentState<T> extends FlowState {");
    states.writeln("final StateRendererType? type;");
    states.writeln("final String? message;");
    states.writeln("final T? data;");
    states.writeln("ContentState({");
    states.writeln("this.type,");
    states.writeln("this.message,");
    states.writeln("this.data,");
    states.writeln("});");
    states.writeln("@override");
    states.writeln("String getMessage() => message ?? '';");
    states.writeln("@override");
    states.writeln(
        "StateRendererType getStateRendererType() => StateRendererType.contentState");
    states.writeln("List<Object?> get props => [data];");
    states.writeln("}\n\n");

    AddFile.searchAndAddFile('$path/states', states.toString());

    ///[BaseResponse]
    final baseResponse = StringBuffer();
    baseResponse.writeln(Imports.create(
      filePath: buildStep.inputId.path,
      libs: ["import 'package:json_annotation/json_annotation.dart';"],
    ));
    baseResponse.writeln("part 'base_response.g.dart';");
    baseResponse.writeln(" @JsonSerializable(genericArgumentFactories: true)");
    baseResponse.writeln("class BaseResponse<T> {");
    baseResponse.writeln("final T? data;");
    baseResponse.writeln("String message;");
    baseResponse.writeln("T? data;");
    baseResponse.writeln("BaseResponse({");
    baseResponse.writeln("this.data,");
    baseResponse.writeln("required this.message,");
    baseResponse.writeln("required this.success,");
    baseResponse.writeln("});");
    baseResponse.writeln("factory BaseResponse.fromJson(");
    baseResponse.writeln(
        "Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>");
    baseResponse.writeln("_\$BaseResponseFromJson(json, fromJsonT);");
    baseResponse.writeln("}\n\n");

    AddFile.searchAndAddFile('$path/BaseResponse', baseResponse.toString());

    ///[Fold]
    final fold = StringBuffer();
    fold.writeln(Imports.create(
      filePath: buildStep.inputId.path,
      imports: ["Failure"],
      libs: [
        "import 'dart:developer';",
        "import 'package:eitherx/eitherx.dart';"
      ],
    ));

    fold.writeln("extension OnEither<T> on Either<Failure, T> {");
    fold.writeln("dynamic right(Function(T data) callBack) {");
    fold.writeln("return fold(");
    fold.writeln("(failure) {");
    fold.writeln("log('Error! \$failure');");
    fold.writeln(" },");
    fold.writeln("(data) {");
    fold.writeln("callBack(data);");
    fold.writeln("return data;");
    fold.writeln("},");
    fold.writeln(");");
    fold.writeln("}");
    fold.writeln("dynamic left(Function(Failure failure) callBack) {");
    fold.writeln("return fold(");
    fold.writeln("(failure) {");
    fold.writeln("log(failure.code);");
    fold.writeln("log(failure.message);");
    fold.writeln("callBack(failure);");
    fold.writeln("return failure;");
    fold.writeln("},");
    fold.writeln("(data) {},");
    fold.writeln(");");
    fold.writeln("}");
    fold.writeln("}");

    AddFile.searchAndAddFile('$path/fold', fold.toString());

    return '';
  }
}
