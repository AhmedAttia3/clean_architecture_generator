import 'dart:io';

import 'package:mvvm_generator/formatter/names.dart';

class ReadImports {
  static String file(String fileName) {
    final projectDir = Directory.current;
    final filePath = '${projectDir.path}/$fileName';
    final file = File(filePath);
    if (file.existsSync()) {
      final content = file
          .readAsStringSync()
          .split('part')[0]
          .replaceFirst("import 'package:annotations/annotations.dart';", '')
          .replaceFirst("import 'package:dio/dio.dart';", '')
          .replaceFirst("import 'package:retrofit/http.dart';", '')
          .replaceAll("'../", "'../../");
      return content;
    }
    throw Exception('File not exist');
  }

  static String imports({
    required String filePath,
    String repositoryName = '',
    String requestName = '',
    String useCaseName = '',
    bool hasCache = false,
    bool isTest = false,
  }) {
    final names = Names();
    String data = file(filePath);
    data += "import 'package:eitherx/eitherx.dart';\n";
    if (isTest) {
      data += "import 'package:flutter_test/flutter_test.dart';\n";
      data += "import 'package:mockito/mockito.dart';\n";
      data += "import 'package:mockito/annotations.dart';\n";
    } else {
      data += "import 'package:injectable/injectable.dart';\n";
      data += "import '/core/base_use_case.dart';\n";
    }
    if (hasCache) {
      data += "import 'package:shared_preferences/shared_preferences.dart';\n";
    }

    if (useCaseName.isNotEmpty) {
      data +=
          "import 'package:${base(filePath)}/use-cases/${names.camelCaseToUnderscore(useCaseName)}.dart';\n";
    }
    if (requestName.isNotEmpty) {
      data +=
          "import 'package:${base(filePath)}/requests/${names.camelCaseToUnderscore(requestName)}.dart';\n";
    }
    if (repositoryName.isNotEmpty) {
      data +=
          "import 'package:${base(filePath)}/repository/${names.camelCaseToUnderscore(repositoryName)}.dart';\n";
    }
    return data;
  }

  static String base(String baseFilePath) {
    final projectDir = Directory.current;
    final parent = projectDir.absolute.uri.path.split('/');
    return "${parent.elementAt(parent.length - 2)}${(baseFilePath.split('/')..removeLast()).join('/')}"
        .replaceFirst('lib', '');
  }
}
