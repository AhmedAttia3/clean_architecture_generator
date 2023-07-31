import 'package:analyzer/dart/element/element.dart';

class UseCaseModel {
  final String type;
  final String name;
  final MethodElement declaration;
  final List<ParameterElement> parameters;
  final String? comment;

  const UseCaseModel({
    required this.type,
    required this.name,
    required this.parameters,
    required this.declaration,
    this.comment,
  });
}
