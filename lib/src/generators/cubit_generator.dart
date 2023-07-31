import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:generators/formatter/method_format.dart';
import 'package:generators/formatter/names.dart';
import 'package:generators/src/add_file_to_project.dart';
import 'package:source_gen/source_gen.dart';

import '../model_visitor.dart';

class CubitGenerator extends GeneratorForAnnotation<CubitAnnotation> {
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

    final classBuffer = StringBuffer();

    for (var method in visitor.useCases) {
      final content = StringBuffer();
      final cubitName = '${names.firstUpper(method.name)}Cubit';
      final useCaseName = '${names.firstUpper(method.name)}UseCase';
      final requestName = '${names.firstUpper(method.name)}Request';
      final type = methodFormat.returnType(method.type);
      final hasData = !type.contains('BaseResponse<dynamic>');
      content
          .writeln(imports(requestName: requestName, useCaseName: useCaseName));
      content.writeln('@injectable');
      content.writeln('class $cubitName extends Cubit<FlowState> {');
      content.writeln('final $useCaseName _${names.firstLower(useCaseName)};');
      if (hasData) {
        if (type.contains('List')) {
          content.writeln('$type ${names.subName(method.name)} = [];');
        } else {
          content.writeln('$type? ${names.subName(method.name)};');
        }
      }
      content.writeln(
          '$cubitName(this._${names.firstLower(useCaseName)}) : super(ContentState());');
      content.writeln(
          'Future<void> execute(${methodFormat.parameters(method.parameters)}) async {');
      content
          .writeln('emit(LoadingState(type: StateRendererType.popUpLoading));');
      content.writeln(
          'final res = await _${names.firstLower(useCaseName)}.execute(');
      content.writeln(
          "request : ${useCaseName}Request(${methodFormat.passingParameters(method.parameters)}),");
      content.writeln(');');
      content.writeln('res.left((failure) {');
      content.writeln('emit(ErrorState(');
      content.writeln('type: StateRendererType.toastError,');
      content.writeln('message: failure.message,');
      content.writeln('));');
      content.writeln('});');
      content.writeln('res.right((data) {');
      content.writeln('if (data.success) {');
      if (hasData) {
        content.writeln('if(data.data != null){');
        content.writeln('${names.subName(method.name)} = data.data!;');
        content.writeln('}');
      }
      content.writeln('emit(SuccessState(');
      content.writeln('message: data.message,');
      content.writeln('type: StateRendererType.contentState,');
      content.writeln('));');
      content.writeln('} else {');
      content.writeln('emit(SuccessState(');
      content.writeln('message: data.message,');
      content.writeln('type: StateRendererType.toastError,');
      content.writeln('));');
      content.writeln('}');
      content.writeln('});');
      content.writeln('}');
      content.writeln('}');
      AddFile.save('$path/$cubitName', content.toString());
      classBuffer.write(content);

      ///[get cache]
      if (method.comment?.contains('///cache') == true) {
        final getContent = StringBuffer();
        getContent.writeln(
            imports(requestName: requestName, useCaseName: useCaseName));
        getContent.writeln('@injectable');
        getContent.writeln('class Get$cubitName extends Cubit<FlowState> {');
        getContent.writeln('final Get$useCaseName _get$useCaseName;');
        final data = names.subName(method.name);
        getContent.writeln('final $type? $data;');
        getContent.writeln(
            'Get$cubitName(this._get$useCaseName) : super(ContentState());');
        getContent.writeln('void execute() {');
        getContent.writeln(
            'emit(LoadingState(type: StateRendererType.fullScreenLoading));');
        getContent.writeln('final res =  _get$useCaseName.execute();');
        getContent.writeln('res.right((data) {');
        getContent.writeln('$data = data;');
        getContent.writeln('emit(ContentState());');
        getContent.writeln('});');
        getContent.writeln('res.left((failure) {');
        getContent.writeln('emit(ErrorState(');
        getContent.writeln('type: StateRendererType.toastError,');
        getContent.writeln('message: failure.message,');
        getContent.writeln('));');
        getContent.writeln('});');
        getContent.writeln('}');
        getContent.writeln('}');

        AddFile.save('$path/Get$cubitName', getContent.toString());
        classBuffer.write(getContent);
      }
    }
    return classBuffer.toString();
  }

  String imports({
    required String useCaseName,
    required String requestName,
  }) {
    String data = "import 'dart:convert';";
    data += "import 'package:eitherx/eitherx.dart';";
    data += "import 'package:injectable/injectable.dart';";
    data +=
        "import './use-cases/${names.camelCaseToUnderscore(useCaseName)}'';";
    data += "import './requests/${names.camelCaseToUnderscore(requestName)}'';";
    return data;
  }
}
