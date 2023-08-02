import 'dart:developer';
import 'dart:io';

import 'package:mvvm_generator/formatter/names.dart';

class AddFile {
  static void save(
    String fileName,
    String content, {
    String extension = 'dart',
  }) {
    try {
      final projectDir = Directory.current;
      final names = Names();
      final filePath =
          '${projectDir.path}/${names.camelCaseToUnderscore(fileName)}.$extension';
      final dir = Directory(path(filePath));
      if (!dir.existsSync()) {
        dir.createSync();
      }

      final file = File(filePath);
      if (!file.existsSync()) {
        file.writeAsStringSync(content);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static String path(String fileName) {
    return (fileName.split('/')..removeLast()).join('/');
  }
}
