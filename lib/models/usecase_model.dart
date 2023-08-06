class UseCaseModel {
  final String type;
  final String name;
  final List<CommendType> parameters;
  final bool isPaging, isCache;
  List<CommendType> functionSets = [];
  List<CommendType> emitSets = [];
  List<CommendType> textControllers = [];

  UseCaseModel({
    required this.type,
    required this.name,
    required this.parameters,
    required this.isPaging,
    required this.isCache,
    required this.functionSets,
    required this.textControllers,
    required this.emitSets,
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
