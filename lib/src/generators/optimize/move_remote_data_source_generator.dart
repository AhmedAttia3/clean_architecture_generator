import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/src/add_file_to_project.dart';
import 'package:clean_architecture_generator/src/annotations.dart';
import 'package:source_gen/source_gen.dart';

import '../../../clean_architecture_generator.dart';

class MoveRemoteDataSourceGenerator
    extends GeneratorForAnnotation<ArchitectureAnnotation> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final currentPath = AddFile.getDirectories(buildStep.inputId.path);
    final fileName =
        buildStep.inputId.path.split('/').last.replaceFirst('.dart', '');
    final path = "$currentPath/data/data-sources";

    await AddFile.move(fileName, path, currentPath);
    return '';
  }
}
