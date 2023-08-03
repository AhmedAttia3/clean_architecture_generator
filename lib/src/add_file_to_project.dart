import 'dart:io';

import 'package:mvvm_generator/formatter/names.dart';

class AddFile {
  static void save(
    String fileName,
    String content, {
    String extension = 'dart',
  }) {
    final projectDir = Directory.current;
    final names = Names();
    final filePath =
        '${projectDir.path}/${names.camelCaseToUnderscore(fileName)}.$extension';
    final dir = Directory(path(filePath));
    if (!dir.existsSync()) {
      try {
        dir.createSync();
      } catch (e) {
        final paths = path(filePath).split('/');
        String exist = '';
        for (var path in paths) {
          exist += '$path/';
          final dir = Directory(exist);
          if (dir.existsSync()) continue;
          dir.createSync();
        }
      }
    }

    final file = File(filePath);
    if (!file.existsSync()) {
      file.writeAsStringSync(content);
    }
    // else {
    //   StringBuffer buffer = StringBuffer(file.readAsStringSync());
    //   content = content.replaceAll(' ', '');
    //   content = content.replaceFirst(buffer.toString().replaceAll(' ', ''), '');
    //   buffer.writeln(content);
    //   file.writeAsStringSync(buffer.toString());
    // }
  }

  static String path(String fileName) {
    return (fileName.split('/')..removeLast()).join('/');
  }
}
