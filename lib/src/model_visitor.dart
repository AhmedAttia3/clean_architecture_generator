// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:clean_architecture_generator/clean_architecture_generator.dart';
import 'package:clean_architecture_generator/src/models/usecase_model.dart';

class ModelVisitor extends GeneralizingElementVisitor<void> {
  String className = '';
  List<UseCaseModel> useCases = [];

  @override
  visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    className = returnType.replaceFirst('*', '');
    if (!className.contains('RemoteDataSource')) {
      className = "${className}RemoteDataSource";
    }
  }

  @override
  visitMethodElement(MethodElement element) {
    final path =
        element.declaration.source.toString().replaceFirst("/example/", "");
    final methods = getCleanMethods(path);
    for (var method in methods) {
      useCases.add(
        UseCaseModel(
          type: "Future<${method.response}>",
          name: method.name,
          endPoint: method.endPoint,
          requestParameters: method.parameters,
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
          requestType: method.requestType,
          methodType: method.methodType,
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

      methods.add(CleanMethodModel.fromJson(jsonDecode(method)));
    }

    return methods;
  }
}
