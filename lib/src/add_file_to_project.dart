import 'dart:io';

import 'package:generators/formatter/names.dart';

class AddFile {
  static void save(String fileName, String content) {
    final projectDir = Directory.current;
    final names = Names();
    final filePath =
        '${projectDir.path}/${names.camelCaseToUnderscore(fileName)}.dart';
    final dir = Directory(path(filePath));
    if (!dir.existsSync()) {
      dir.createSync();
    }
    final file = File(filePath);

    file.writeAsStringSync(content);
  }

  static String path(String fileName) {
    return (fileName.split('/')..removeLast()).join('/');
  }
}
