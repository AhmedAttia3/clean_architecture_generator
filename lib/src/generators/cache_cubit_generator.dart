import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/annotations.dart';
import 'package:clean_architecture_generator/src/imports_file.dart';
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
    final path =
        "${AddFile.getDirectories(buildStep.inputId.path)}/presentation/logic";
    final visitor = ModelVisitor();

    final methodFormat = MethodFormat();
    element.visitChildren(visitor);

    final cubits = StringBuffer();

    for (var method in visitor.useCases) {
      final varName = names.subName(method.name);
      final requestType = names.requestType(method.name);
      final type = methodFormat.returnType(method.type);
      final responseType = names.responseType(type);

      ///[get cache]
      if (method.isCache) {
        final getCacheCubit = StringBuffer();
        final cacheCubitType = names.getCacheCubitType(method.name);
        final cacheUseCaseName =
            names.useCaseName(names.getCacheName(method.name));
        final cacheUseCaseType =
            names.useCaseType(names.getCacheName(method.name));

        ///[Imports]
        getCacheCubit.writeln(Imports.create(
          imports: [requestType, cacheUseCaseType],
          filePath: buildStep.inputId.path,
          isCubit: true,
        ));
        getCacheCubit.writeln('@injectable');
        getCacheCubit
            .writeln('class $cacheCubitType extends Cubit<FlowState> {');
        getCacheCubit.writeln('final $cacheUseCaseType _$cacheUseCaseName;');
        if (responseType.contains('List')) {
          getCacheCubit.writeln('$responseType $varName = [];');
        } else {
          getCacheCubit.writeln('$responseType? $varName;');
        }
        getCacheCubit.writeln(
            '$cacheCubitType(this._$cacheUseCaseName) : super(ContentState());');
        getCacheCubit.writeln('void execute() {');
        getCacheCubit.writeln(
            'emit(LoadingState(type: StateRendererType.fullScreenLoading));');
        getCacheCubit.writeln('final res =  _$cacheUseCaseName.execute();');
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

        AddFile.save('$path/$cacheCubitType', getCacheCubit.toString());
        cubits.writeln(getCacheCubit);
      }
    }
    return cubits.toString();
  }
}
