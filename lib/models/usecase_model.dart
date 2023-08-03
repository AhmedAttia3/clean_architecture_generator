import 'package:analyzer/dart/element/element.dart';

class UseCaseModel {
  final String type;
  final String name;
  final MethodElement declaration;
  final List<ParameterElement> parameters;
  final bool isPaging, isCache;
  List<CommendType> functionSets = [];
  List<CommendType> textControllers = [];

  UseCaseModel({
    required this.type,
    required this.name,
    required this.parameters,
    required this.declaration,
    required this.isPaging,
    required this.isCache,
    required this.functionSets,
    required this.textControllers,
  });
}

class CommendType {
  final String type;
  final String name;

  const CommendType({
    required this.name,
    required this.type,
  });
}
