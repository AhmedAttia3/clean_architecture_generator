import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:generators/formatter/names.dart';
import 'package:source_gen/source_gen.dart';

import '../add_file_to_project.dart';
import '../model_visitor.dart';

class RequestsGenerator extends GeneratorForAnnotation<RequestsAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final path = "${AddFile.path(buildStep.inputId.path)}/requests";
    final visitor = ModelVisitor();
    final names = Names();
    element.visitChildren(visitor);

    final classBuffer = StringBuffer();

    for (var method in visitor.useCases) {
      final content = StringBuffer();
      final requestName = '${names.firstUpper(method.name)}Request';
      content.writeln("import 'package:json_annotation/json_annotation.dart';");
      content.writeln(
          "part '${names.camelCaseToUnderscore(requestName)}.g.dart';");
      content.writeln('///[$requestName]');
      content.writeln('///[Implementation]');
      content.writeln('@JsonSerializable()');
      content.writeln('class $requestName {');
      for (var pram in method.parameters) {
        content.writeln('final ${pram.type} ${pram.name};');
      }
      if (method.parameters.isNotEmpty) {
        content.writeln('const $requestName({');
        for (var pram in method.parameters) {
          content.writeln('required this.${pram.name},');
        }
        content.writeln('});\n');
      } else {
        content.writeln('const $requestName();\n');
      }
      content.writeln(
          'factory $requestName.fromJson(Map<String, dynamic> json) => _\$${requestName}FromJson(json);');
      content.writeln(
          'Map<String, dynamic> toJson() => _\$${requestName}ToJson(this);');
      content.writeln('}\n');

      AddFile.save('$path/$requestName', content.toString());
      classBuffer.write(content);
    }
    return classBuffer.toString();
  }
}
