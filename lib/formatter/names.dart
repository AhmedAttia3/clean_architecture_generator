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
    return value.replaceFirst('get', '');
  }

  String modelName(String value) {
    return value.split('<').elementAt(1).replaceAll('>', "");
  }

  String baseModelName(String value) {
    return value
        .replaceFirst('BaseResponse<', "")
        .replaceFirst('>', "")
        .replaceFirst('List<', '')
        .replaceFirst('>', '')
        .replaceFirst('?', '');
  }

  String varType(dynamic type) {
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

  String responseDataType(String value) {
    return value
        .replaceFirst('BaseResponse<', "")
        .replaceFirst('>', "")
        .replaceFirst('?', '');
  }

  String camelCaseToUnderscore(String input) {
    final regex = RegExp('([a-z0-9])([A-Z])');
    return input
        .replaceAllMapped(
            regex, (match) => '${match.group(1)}_${match.group(2)}')
        .toLowerCase();
  }

  String localDataSourceType(String value) {
    String type = firstUpper(value);
    if (type.contains('RemoteDataSource')) {
      type = type.replaceFirst('RemoteDataSource', "LocalDataSource");
    } else {
      type = "${type}LocalDataSource";
    }
    return type;
  }
}
