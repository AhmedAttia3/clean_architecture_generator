// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:generators/models/usecase_model.dart';

List<String> paths = [];

class ModelVisitor extends SimpleElementVisitor<void> {
  String className = '';
  List<UseCaseModel> useCases = [];
  List<ParameterElement> constructorParams = [];
  List<String> paramsType = [];
  Map<String, String> params = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    className = returnType.replaceFirst('*', '');
    paths.add(className);
    constructorParams = element.declaration.parameters;
    for (var param in constructorParams) {
      paramsType.add(param.type.toString());
      params[param.type.toString()] = param.name;
    }
  }

  @override
  void visitMethodElement(MethodElement element) {
    final type = element.returnType.toString();
    final name = element.name.toString();
    final parameters = element.parameters;

    useCases.add(UseCaseModel(
      type: type,
      name: name,
      parameters: parameters,
      declaration: element.declaration,
      comment: element.documentationComment,
    ));
    super.visitMethodElement(element);
  }
}
