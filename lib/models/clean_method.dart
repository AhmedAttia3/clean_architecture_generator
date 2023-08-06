enum MethodType { POST, GET, DELETE, PATCH, POST_MULTI_PART }

enum RequestType { Fields, Body }

enum ParamType { Filed, Query, Path }

enum ParamProp { none, Set, EmitSet, TextController }

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
    this.requestType = RequestType.Fields,
    this.isCache = false,
    this.isPaging = false,
    this.parameters = const [],
  });

  factory CleanMethod.fromJson(Map<String, dynamic> map) {
    final methodTypeIndex = MethodType.values
        .indexWhere((element) => element.name == map['methodType']);
    final requestTypeIndex = RequestType.values
        .indexWhere((element) => element.name == map['requestType']);

    final methodType =
        MethodType.values[methodTypeIndex == -1 ? 0 : methodTypeIndex];
    final requestType =
        RequestType.values[requestTypeIndex == -1 ? 0 : requestTypeIndex];

    List<Param> params = [];
    for (var item in map['parameters'] ?? []) {
      params.add(Param.fromJson(item));
    }

    return CleanMethod(
      name: map['name'],
      endPoint: map['endPoint'],
      methodType: methodType,
      requestType: requestType,
      parameters: params,
      isPaging: map['isPaging'] ?? false,
      isCache: map['isCache'] ?? false,
    );
  }
}

class Param {
  final String name;
  final ParamType type;
  final ParamProp prop;
  final bool isRequired;

  const Param({
    required this.name,
    required this.type,
    required this.prop,
    this.isRequired = true,
  });

  factory Param.fromJson(Map<String, dynamic> json) {
    final typeIndex =
        ParamType.values.indexWhere((element) => element.name == json['type']);
    final propIndex =
        ParamProp.values.indexWhere((element) => element.name == json['prop']);

    final paramType = ParamType.values[typeIndex == -1 ? 0 : typeIndex];
    final paramProp = ParamProp.values[propIndex == -1 ? 0 : propIndex];

    return Param(
      name: json['name'],
      type: paramType,
      prop: paramProp,
      isRequired: json['isRequired'] ?? true,
    );
  }
}
