import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/clean_architecture_generator.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/imports_file.dart';
// import 'package:clean_architecture_generator/src/imports_file.dart';
import 'package:clean_architecture_generator/src/model_visitor.dart';
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

    ///[kPrint]
    final kPrint = StringBuffer();
    kPrint.writeln(Imports.create(
      filePath: buildStep.inputId.path,
      libs: [
        "import 'dart:convert';",
        "import 'dart:developer';",
        "import 'package:flutter/foundation.dart';",
      ],
    ));
    kPrint.writeln('///[kPrint]');
    kPrint.writeln('///[Implementation]');
    kPrint.writeln("void kPrint(dynamic data) {");
    kPrint.writeln("if (kDebugMode) {");
    kPrint.writeln("_pr(data.toString());");
    kPrint.writeln("} else if (data is Map) {");
    kPrint.writeln("_pr(jsonEncode(data));");
    kPrint.writeln("} else {");
    kPrint.writeln("_pr(data.toString());");
    kPrint.writeln("}");
    kPrint.writeln("}\n\n");
    kPrint.writeln("void _pr(String data) {");
    kPrint.writeln("if (data.length > 500) {");
    kPrint.writeln("log(data);");
    kPrint.writeln("} else {");
    kPrint.writeln("print(data);");
    kPrint.writeln("}");
    kPrint.writeln("log(StackTrace.current.toString().split('\\n')[2]);");
    kPrint.writeln("}");

    AddFile.searchAndAddFile('$path/print', kPrint.toString());

    ///[Network]
    final network = StringBuffer();
    network.writeln(Imports.create(
      filePath: buildStep.inputId.path,
      libs: [
        "import 'package:injectable/injectable.dart';",
        "import 'package:internet_connection_checker/internet_connection_checker.dart';",
      ],
    ));
    network.writeln('///[Network]');
    network.writeln('///[Implementation]');
    network.writeln("abstract class NetworkInfo {");
    network.writeln("Future<bool> get isConnected;");
    network.writeln("}\n\n");
    network.writeln("@Injectable(as: NetworkInfo)");
    network.writeln("class NetworkInfoImpl implements NetworkInfo {");
    network.writeln("InternetConnectionChecker internetConnectionChecker;");
    network.writeln("NetworkInfoImpl(this.internetConnectionChecker);");
    network.writeln("@override");
    network.writeln(
        "Future<bool> get isConnected => internetConnectionChecker.hasConnection;");
    network.writeln("}");

    AddFile.searchAndAddFile('$path/network', network.toString());

    ///[BaseUseCase]
    final baseUseCase = StringBuffer();
    baseUseCase.writeln("import 'package:eitherx/eitherx.dart';");
    baseUseCase.writeln('///[BaseUseCase]');
    baseUseCase.writeln('///[Implementation]');
    baseUseCase.writeln("abstract class BaseUseCase<RES, POS> {");
    baseUseCase.writeln("RES execute({POS? request});");
    baseUseCase.writeln("}");

    AddFile.searchAndAddFile('$path/base_use_case', baseUseCase.toString());

    ///[Failure]
    final failure = StringBuffer();
    failure.writeln('///[Failure]');
    failure.writeln('///[Implementation]');
    failure.writeln("class Failure {");
    failure.writeln("int code; // 200, 201, 400, 303..500 and so on");
    failure.writeln("String message; // error , success\n");
    failure.writeln("Failure(this.code, this.message);");
    failure.writeln("}");

    AddFile.searchAndAddFile('$path/failure', failure.toString());

    ///[SafeApi]
    final safeApi = StringBuffer();
    safeApi.writeln(Imports.create(
      filePath: buildStep.inputId.path,
      imports: ['Failure', 'print', 'network'],
      libs: [
        "import 'dart:developer';",
        "import 'package:eitherx/eitherx.dart';",
        "import 'package:injectable/injectable.dart';",
      ],
    ));
    safeApi.writeln('///[SafeApi]');
    safeApi.writeln('///[Implementation]');
    safeApi.writeln("@injectable");
    safeApi.writeln("class SafeApi {");
    safeApi.writeln("final NetworkInfo networkInfo;");
    safeApi.writeln("SafeApi(this.networkInfo);");
    safeApi.writeln("Future<Either<Failure, T>> call<T>({");
    safeApi.writeln("required Future<T> apiCall,");
    safeApi.writeln("}) async {");
    safeApi.writeln("final hasConnection = await networkInfo.isConnected;");
    safeApi.writeln("if (hasConnection) {");
    safeApi.writeln("try {");
    safeApi.writeln("final response = await apiCall;");
    safeApi.writeln("return Right(response);");
    safeApi.writeln("} catch (error) {");
    safeApi.writeln('kPrint("API Error: \$error");');
    safeApi.writeln('return Left(Failure(600, error.toString()));');
    safeApi.writeln('}');
    safeApi.writeln('} else {');
    safeApi.writeln("return Left(Failure(500, 'No Internet'));");
    safeApi.writeln('}');
    safeApi.writeln('}');
    safeApi.writeln('}');

    AddFile.searchAndAddFile('$path/safe_request_handler', safeApi.toString());

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
      imports: ["StateRenderer"],
      libs: ["import 'package:equatable/equatable.dart';"],
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
    states.writeln("@override");
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
      states.writeln("@override");
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
    states.writeln("@override");
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
        "StateRendererType getStateRendererType() => StateRendererType.contentState;");
    states.writeln("@override");
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
    baseResponse.writeln("bool success;");
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
      imports: ["Failure", "print"],
      libs: [
        "import 'dart:developer';",
        "import 'package:eitherx/eitherx.dart';"
      ],
    ));

    fold.writeln("extension OnEither<T> on Either<Failure, T> {");
    fold.writeln("dynamic right(Function(T data) callBack) {");
    fold.writeln("return fold(");
    fold.writeln("(failure) {");
    fold.writeln("kPrint('Error! \$failure');");
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
    fold.writeln("kPrint(failure.code);");
    fold.writeln("kPrint(failure.message);");
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
