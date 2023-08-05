import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/annotations.dart';
import 'package:source_gen/source_gen.dart';

class MoveRemoteDataSourceGenerator
    extends GeneratorForAnnotation<ArchitectureAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final currentPath = AddFile.getDirectories(buildStep.inputId.path);
    final fileName =
        buildStep.inputId.path.split('/').last.replaceFirst('.dart', '');
    final path = "$currentPath/data/data-sources";

    AddFile.move(fileName, path, currentPath);
    return '';
  }
}
