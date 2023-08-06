// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:clean_architecture_generator/models/clean_method.dart';
import 'package:clean_architecture_generator/models/usecase_model.dart';

class ModelVisitor extends GeneralizingElementVisitor<void> {
  String className = '';
  List<UseCaseModel> useCases = [];

  @override
  visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    className = returnType.replaceFirst('*', '');
  }

  @override
  visitMethodElement(MethodElement element) {
    final path =
        element.declaration.source.toString().replaceFirst("/example/", "");
    final methods = getCleanMethods(path);
    for (var method in methods) {
      useCases.add(
        UseCaseModel(
          type: method.type,
          name: method.name,
          parameters: method.parameters
              .map((e) => CommendType(name: e.name, type: e.dataType.name))
              .toList(),
          functionSets: method.parameters
              .where((e) => e.prop == ParamProp.Set)
              .map((e) => CommendType(name: e.name, type: e.dataType.name))
              .toList(),
          textControllers: method.parameters
              .where((e) => e.prop == ParamProp.TextController)
              .map((e) => CommendType(name: e.name, type: e.dataType.name))
              .toList(),
          emitSets: method.parameters
              .where((e) => e.prop == ParamProp.EmitSet)
              .map((e) => CommendType(name: e.name, type: e.dataType.name))
              .toList(),
          isCache: method.isCache,
          isPaging: method.isPaging,
        ),
      );
    }
    return null;
  }

  List<CleanMethodModel> getCleanMethods(String path) {
    final file = File(path).readAsStringSync();
    final pattern = RegExp('\\s+');
    String items = file
        .replaceAll(";", "#")
        .replaceAll("\n", "")
        .replaceAll(pattern, "")
        .trim()
        .replaceAll("methods(){return", "!");
    items = items
        .substring(items.indexOf('!') + 2, items.lastIndexOf('#') - 1)
        .replaceAll('const', "");

    final cleans = items.split("CleanMethod");
    cleans.removeWhere((item) => item.isEmpty);
    List<CleanMethodModel> methods = [];
    for (var method in cleans) {
      final cleanMethodType = method.substring(1, method.indexOf(">"));
      method = method.replaceFirst("<$cleanMethodType>", "");

      method = method
          .replaceAll('Param(', '{"')
          .replaceAll('MethodType.', '"')
          .replaceAll('RequestType.', '"')
          .replaceAll('ParamType.', '"')
          .replaceAll('ParamProp.', '"')
          .replaceAll('ParamDataType.', '"')
          .replaceAll('(', '{"')
          .replaceAll(')', '}')
          .replaceAll(':', '":')
          .replaceAll(',', ',"')
          .replaceAll("'", '"')
          .replaceAll(",", '",')
          .replaceAll('""', '"')
          .replaceAll(',"}","', '},')
          .replaceAll(',]"},', ']}')
          .replaceAll('true"', 'true')
          .replaceAll('false"', 'false');

      methods.add(CleanMethodModel.fromJson(
          jsonDecode(method)..['type'] = cleanMethodType));
    }

    return methods;
  }
}
