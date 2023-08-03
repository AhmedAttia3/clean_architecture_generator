import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/annotations.dart';
import 'package:clean_architecture_generator/src/read_imports_file.dart';
import 'package:source_gen/source_gen.dart';

import '../model_visitor.dart';

class CacheCubitGenerator
    extends GeneratorForAnnotation<ArchitectureAnnotation> {
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
      final varName = names.subName(method.name);
      final cubitName = '${names.firstUpper(method.name)}Cubit';
      final useCaseName = '${names.firstUpper(method.name)}UseCase';
      final requestName = '${names.firstUpper(method.name)}Request';
      final type = methodFormat.returnType(method.type);
      final responseDataType = names.responseDataType(type);

      ///[get cache]
      if (method.isCache) {
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
