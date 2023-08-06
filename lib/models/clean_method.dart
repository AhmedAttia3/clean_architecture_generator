enum MethodType { GET, POST, DELETE, PATCH, POST_MULTI_PART }

enum RequestType { Body, OneFiled }

enum ParamType { Filed, Query, Path }

enum ParamProp { Set, EmitSet, TextController, none }

class CleanMethod<T> {
  final String name;
  final String endPoint;
  final MethodType methodType;
  final RequestType requestType;
  final List<Param> parameters;
  final bool isPaging, isCache;

  const CleanMethod({
    required this.name,
    required this.endPoint,
    this.methodType = MethodType.POST,
    this.requestType = RequestType.OneFiled,
    this.isCache = false,
    this.isPaging = false,
    this.parameters = const [],
  });
}

class Param {
  final String name;
  final bool isRequired;
  final ParamType type;
  final ParamProp prop;

  const Param({
    required this.name,
    this.type = ParamType.Filed,
    this.prop = ParamProp.none,
    this.isRequired = true,
  });
}
