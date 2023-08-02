import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:generators/formatter/method_format.dart';
import 'package:generators/formatter/names.dart';
import 'package:generators/src/add_file_to_project.dart';
import 'package:generators/src/mvvm_generator_annotations.dart';
import 'package:generators/src/read_imports_file.dart';
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
      final hasParams = method.parameters.isNotEmpty;
      final cubitName = '${names.firstUpper(method.name)}Cubit';
      final useCaseName = '${names.firstUpper(method.name)}UseCase';
      final requestName = '${names.firstUpper(method.name)}Request';
      final type = methodFormat.returnType(method.type);
      final hasData = !type.contains('BaseResponse<dynamic>');
      cubit.writeln(ReadImports.imports(
        requestName: hasParams ? requestName : "",
        useCaseName: useCaseName,
        filePath: buildStep.inputId.path,
      ));
      cubit.writeln('///[$cubitName]');
      cubit.writeln('///[Implementation]');
      cubit.writeln('@injectable');
      cubit.writeln('class $cubitName extends Cubit<FlowState> {');
      cubit.writeln('final $useCaseName _${names.firstLower(useCaseName)};');
      if (hasData) {
        final filed =
            type.replaceFirst('BaseResponse<', '').replaceFirst('>', '');
        if (filed.contains('List')) {
          cubit.writeln('$filed ${names.subName(method.name)} = [];');
        } else {
          cubit.writeln('$filed ${names.subName(method.name)};');
        }
      }
      cubit.writeln(
          '$cubitName(this._${names.firstLower(useCaseName)}) : super(ContentState());');
      cubit.writeln(
          'Future<void> execute(${methodFormat.parameters(method.parameters)}) async {');
      cubit
          .writeln('emit(LoadingState(type: StateRendererType.popUpLoading));');
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
      cubit.writeln('if (data.success) {');
      if (hasData) {
        cubit.writeln('if(data.data != null){');
        cubit.writeln('${names.subName(method.name)} = data.data!;');
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
      cubit.writeln('}');
      AddFile.save('$path/$cubitName', cubit.toString());
      cubits.writeln(cubit);

      ///[get cache]
      if (method.comment?.contains('///cache') == true) {
        final getCacheCubit = StringBuffer();
        getCacheCubit.writeln(ReadImports.imports(
          requestName: requestName,
          useCaseName: useCaseName,
          filePath: buildStep.inputId.path,
        ));
        getCacheCubit.writeln('@injectable');
        getCacheCubit.writeln('class Get$cubitName extends Cubit<FlowState> {');
        getCacheCubit.writeln('final Get$useCaseName _get$useCaseName;');
        final data = names.subName(method.name);
        getCacheCubit.writeln('final $type? $data;');
        getCacheCubit.writeln(
            'Get$cubitName(this._get$useCaseName) : super(ContentState());');
        getCacheCubit.writeln('void execute() {');
        getCacheCubit.writeln(
            'emit(LoadingState(type: StateRendererType.fullScreenLoading));');
        getCacheCubit.writeln('final res =  _get$useCaseName.execute();');
        getCacheCubit.writeln('res.right((data) {');
        getCacheCubit.writeln('$data = data;');
        getCacheCubit.writeln('emit(ContentState());');
        getCacheCubit.writeln('});');
        getCacheCubit.writeln('res.left((failure) {');
        getCacheCubit.writeln('emit(ErrorState(');
        getCacheCubit.writeln('type: StateRendererType.toastError,');
        getCacheCubit.writeln('message: failure.message,');
        getCacheCubit.writeln('));');
        getCacheCubit.writeln('});');
        getCacheCubit.writeln('}');
        getCacheCubit.writeln('}');

        AddFile.save('$path/Get$cubitName', getCacheCubit.toString());
        cubits.writeln(getCacheCubit);
      }
    }
    return cubits.toString();
  }
}
