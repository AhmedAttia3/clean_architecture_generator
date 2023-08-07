import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/annotations.dart';
import 'package:clean_architecture_generator/src/imports_file.dart';
import 'package:clean_architecture_generator/src/model_visitor.dart';
import 'package:source_gen/source_gen.dart';

class MoveModelsGenerator
    extends GeneratorForAnnotation<ArchitectureAnnotation> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final currentPath = AddFile.getDirectories(buildStep.inputId.path);
    final path = "$currentPath/data/models";
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    final models = Imports.filesInDir("$currentPath/models");
    for (var model in models) {
      final filename = model.split('\\').last.replaceFirst(".dart", "");
      await AddFile.move(filename, path, "$currentPath/models");
    }
    return "";
  }
}
