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
      final isPaging = method.comment?.contains('///page') == true;
      final hasParams = method.parameters.isNotEmpty;
      final cubitName = '${names.firstUpper(method.name)}Cubit';
      final useCaseName = '${names.firstUpper(method.name)}UseCase';
      final requestName = '${names.firstUpper(method.name)}Request';
      final type = methodFormat.returnType(method.type);
      final responseDataType = names.responseDataType(type);
      final baseModelType = names.baseModelName(type);
      final hasData = !type.contains('BaseResponse<dynamic>');

      ///[Imports]
      cubit.writeln(Imports.create(
        imports: [useCaseName, hasParams ? requestName : ""],
        filePath: buildStep.inputId.path,
        isCubit: true,
        isPaging: isPaging,
      ));
      cubit.writeln('///[$cubitName]');
      cubit.writeln('///[Implementation]');
      cubit.writeln('@injectable');
      cubit.writeln('class $cubitName extends Cubit<FlowState> {');
      cubit.writeln('final $useCaseName _${names.firstLower(useCaseName)};');
      if (isPaging) {
        cubit.writeln(
            'late final PagewiseLoadController<$baseModelType> pagewiseController;');
        cubit.writeln(
            '$cubitName(this._${names.firstLower(useCaseName)}) : super(ContentState());');
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
        if (hasData) {
          if (responseDataType.contains('List')) {
            cubit.writeln('$responseDataType $varName = [];');
          } else {
            cubit.writeln('$responseDataType? $varName;');
          }
        }
        cubit.writeln(
            '$cubitName(this._${names.firstLower(useCaseName)}) : super(ContentState());');
        cubit.writeln(
            'Future<void> execute(${methodFormat.parameters(method.parameters)}) async {');
        cubit.writeln(
            'emit(LoadingState(type: StateRendererType.popUpLoading));');
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
        cubit.writeln('}');
      }

      AddFile.save('$path/$cubitName', cubit.toString());
      cubits.writeln(cubit);

      ///[get cache]
      if (method.comment?.contains('///cache') == true) {
        final getCacheCubit = StringBuffer();
        final cacheCubitName = cubitName.replaceFirst('Get', '');
        final cacheUseCaseName = useCaseName.replaceFirst('Get', '');

        ///[Imports]
        getCacheCubit.writeln(Imports.create(
          imports: [requestName, 'GetCache$cacheUseCaseName'],
          filePath: buildStep.inputId.path,
          isCubit: true,
        ));
        getCacheCubit.writeln('@injectable');
        getCacheCubit.writeln(
            'class GetCache$cacheCubitName extends Cubit<FlowState> {');
        getCacheCubit
            .writeln('final GetCache$cacheUseCaseName _get$cacheUseCaseName;');
        if (responseDataType.contains('List')) {
          getCacheCubit.writeln('$responseDataType $varName = [];');
        } else {
          getCacheCubit.writeln('$responseDataType? $varName;');
        }
        getCacheCubit.writeln(
            'GetCache$cacheCubitName(this._get$cacheUseCaseName) : super(ContentState());');
        getCacheCubit.writeln('void execute() {');
        getCacheCubit.writeln(
            'emit(LoadingState(type: StateRendererType.fullScreenLoading));');
        getCacheCubit.writeln('final res =  _get$cacheUseCaseName.execute();');
        getCacheCubit.writeln('res.right((data) {');
        getCacheCubit.writeln('$varName = data;');
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

        AddFile.save('$path/GetCache$cacheCubitName', getCacheCubit.toString());
        cubits.writeln(getCacheCubit);
      }
    }
    return cubits.toString();
  }
}
