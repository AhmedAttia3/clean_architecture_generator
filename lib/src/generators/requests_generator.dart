import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:mvvm_generator/formatter/names.dart';
import 'package:mvvm_generator/src/mvvm_generator_annotations.dart';
import 'package:source_gen/source_gen.dart';

import '../add_file_to_project.dart';
import '../model_visitor.dart';

class RequestsGenerator extends GeneratorForAnnotation<MVVMAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final path = "${AddFile.path(buildStep.inputId.path)}/repository/requests";
    final visitor = ModelVisitor();
    final names = Names();
    element.visitChildren(visitor);

    final requests = StringBuffer();

    for (var method in visitor.useCases) {
      if (method.parameters.isEmpty) {
        continue;
      }
      final request = StringBuffer();
      final requestName = '${names.firstUpper(method.name)}Request';

      ///[Imports]
      request.writeln("import 'package:json_annotation/json_annotation.dart';");
      request.writeln(
          "part '${names.camelCaseToUnderscore(requestName)}.g.dart';");
      request.writeln('///[$requestName]');
      request.writeln('///[Implementation]');
      request.writeln('@JsonSerializable()');
      request.writeln('class $requestName {');
      for (var pram in method.parameters) {
        request.writeln('final ${pram.type} ${pram.name};');
      }
      if (method.parameters.isNotEmpty) {
        request.writeln('const $requestName({');
        for (var pram in method.parameters) {
          request.writeln('required this.${pram.name},');
        }
        request.writeln('});\n');
      } else {
        request.writeln('const $requestName();\n');
      }
      request.writeln(
          'factory $requestName.fromJson(Map<String, dynamic> json) => _\$${requestName}FromJson(json);');
      request.writeln(
          'Map<String, dynamic> toJson() => _\$${requestName}ToJson(this);');
      request.writeln('}\n');

      AddFile.save('$path/$requestName', request.toString());
      requests.write(request);
    }
    return requests.toString();
  }
}
