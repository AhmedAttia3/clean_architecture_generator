import 'dart:io';

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
          .replaceFirst("import 'package:retrofit/http.dart';", '');
      return content;
    }
    throw Exception('File not exist');
  }
}
