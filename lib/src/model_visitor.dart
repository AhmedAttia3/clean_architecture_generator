// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:clean_architecture_generator/models/usecase_model.dart';

List<String> paths = [];

class ModelVisitor extends SimpleElementVisitor<void> {
  String className = '';
  List<UseCaseModel> useCases = [];
  dynamic data;

  @override
  void visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    className = returnType.replaceFirst('*', '');
    paths.add(className);
  }

  @override
  void visitMethodElement(MethodElement element) {
    data += "${element.declaration.toString()} declaration";
    data += "${element.source.fullName.toString()} source fullName";
    data +=
        "${element.source.uri.data?.parameters.toString()} source parameters";
    data += "${element.source.toString()} source";
    data += "${element.returnType.toString()} returnType";
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
