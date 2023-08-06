// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:clean_architecture_generator/models/usecase_model.dart';

import '../models/clean_method.dart';

class ModelVisitor extends GeneralizingElementVisitor<void> {
  String className = '';
  List<UseCaseModel> useCases = [];
  String data = "";

  @override
  void visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    className = returnType.replaceFirst('*', '');
  }

  @override
  void visitMethodElement(MethodElement element) {
    final path =
        element.declaration.source.toString().replaceFirst("/example/", "");
    final method = File(path).readAsStringSync();
    final pattern = RegExp('\\s+');
    final items = method
        .substring(method.indexOf('['), method.indexOf('];') + 1)
        .trim()
        .replaceAll("\n", "")
        .replaceAll(pattern, "")
        .replaceAll('const', "")
        .replaceAll(")", '"}')
        .replaceAll('CleanMethod(', '{"')
        .replaceAll(',', ',"')
        .replaceAll('Param(', '{"')
        .replaceAll('MethodType.', '"')
        .replaceAll('RequestType.', '"')
        .replaceAll('ParamType.', '"')
        .replaceAll('ParamProp.', '"')
        .replaceAll(':', '":')
        .replaceAll("'", '"')
        .replaceAll(',', '",')
        .replaceAll('""', '"')
        .replaceAll(',"}', "}")
        .replaceAll('","]"', "]")
        .replaceAll('","]', "]")
        .replaceAll('}","{', "},{");

    List<CleanMethod> methods = [];
    for (var item in jsonDecode(items)) {
      methods.add(CleanMethod.fromJson(item));
    }

    data += methods.map((e) => e.name).toList().toString();

    final parameters = [...element.parameters];
    final type = element.returnType.toString();
    final name = element.name.toString();
    final comment = element.documentationComment ?? '';
    final prop = propIn(comment: comment, name: 'Prop');
    final textControllers =
        varsIn(comment: comment, name: 'TextController', params: parameters);

    final functionSets =
        varsIn(comment: comment, name: 'FunctionSet', params: parameters);

    final emitSets =
        varsIn(comment: comment, name: 'EmitSet', params: parameters);

    useCases.add(
      UseCaseModel(
        type: type,
        name: name,
        parameters: parameters,
        declaration: element.declaration,
        functionSets: functionSets,
        textControllers: textControllers,
        emitSets: emitSets,
        isCache: prop.contains('cached'),
        isPaging: prop.contains('paging'),
      ),
    );
    super.visitMethodElement(element);
  }

  List<CommendType> varsIn({
    required String comment,
    required String name,
    required List<ParameterElement> params,
  }) {
    List<CommendType> items = [];
    final vars = propIn(comment: comment, name: name);
    if (vars.isNotEmpty) {
      for (var item in vars) {
        final index = params.indexWhere((element) => element.name == item);
        if (index != -1) {
          items.add(
            CommendType(
              name: item,
              type: params[index].type.toString(),
            ),
          );
        }
      }
    }
    return items;
  }

  List<String> propIn({
    required String comment,
    required String name,
  }) {
    if (comment.contains('///$name')) {
      final commends = comment.split('///');
      final index = commends.indexWhere((item) => item.contains(name));
      if (index != -1) {
        return commends[index]
            .replaceFirst(name, '')
            .replaceAll(' ', '')
            .replaceAll('\n', '')
            .replaceAll('[', '')
            .replaceAll(']', '')
            .split(',');
      }
    }
    return [];
  }
}
