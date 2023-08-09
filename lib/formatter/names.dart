class Names {
  String firstUpper(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }

  String firstLower(String value) {
    return value[0].toLowerCase() + value.substring(1);
  }

  String subName(String value) {
    if (value.contains('get')) {
      return firstLower(value.replaceFirst('get', ''));
    }
    return firstLower(value);
  }

  String subUpperName(String value) {
    if (value.contains('get')) {
      return firstUpper(value.replaceFirst('get', ''));
    }
    return firstUpper(value);
  }

  String getCacheName(String value) {
    return "getCache${subUpperName(value)}";
  }

  String keyValue(String value) {
    return subUpperName(value).toUpperCase();
  }

  String keyName(String value) {
    return subName(value);
  }

  String getCacheType(String value) {
    return "GetCache${subUpperName(value)}";
  }

  String cacheName(String value) {
    return "cache${subUpperName(value)}";
  }

  String cacheType(String value) {
    return "Cache${subUpperName(value)}";
  }

  String getCacheCubitName(String value) {
    return "getCache${subUpperName(value)}Cubit";
  }

  String getCacheCubitType(String value) {
    return "GetCache${subUpperName(value)}Cubit";
  }

  String cacheCubitName(String value) {
    return "cache${subUpperName(value)}Cubit";
  }

  String cacheCubitType(String value) {
    return "Cache${subUpperName(value)}Cubit";
  }

  String requestName(String value) {
    return "${firstLower(value)}Request";
  }

  String requestType(String value) {
    return "${firstUpper(value)}Request";
  }

  String useCaseName(String value) {
    return "${firstLower(value)}UseCase";
  }

  String useCaseType(String value) {
    return "${firstUpper(value)}UseCase";
  }

  String cubitType(String value) {
    return "${firstUpper(value)}Cubit";
  }

  String cubitName(String value) {
    return "${firstLower(value)}Cubit";
  }

  String repositoryName(String value) {
    return firstLower(value);
  }

  String ImplName(String value) {
    return '${firstLower(value)}Implement';
  }

  String ImplType(String value) {
    return '${firstUpper(value)}Implement';
  }

  String modelName(String value) {
    return value.split('<').elementAt(1).replaceAll('>', "");
  }

  String ModelType(String value) {
    return value.replaceFirst('?', '').replaceAll('>', '').split('<').last;
  }

  String modelRuntimeType(dynamic type) {
    type = type.toString();
    if (type == "int" ||
        type == "String" ||
        type == "bool" ||
        type == "double" ||
        type == "List" ||
        type == "Map") {
      return type;
    }
    return 'dynamic';
  }

  String camelCaseToUnderscore(String input) {
    final regex = RegExp('([a-z0-9])([A-Z])');
    return input
        .replaceAllMapped(
            regex, (match) => '${match.group(1)}_${match.group(2)}')
        .toLowerCase();
  }

  String underscoreToCamelCase(String input) {
    List<String> parts = input.split('_');
    String camelCase = parts[0];

    for (int i = 1; i < parts.length; i++) {
      String word = parts[i];
      String capitalizedWord = word[0].toUpperCase() + word.substring(1);
      camelCase += capitalizedWord;
    }

    return camelCase;
  }

  String localDataSourceName(String value) {
    return firstLower(value);
  }
}
