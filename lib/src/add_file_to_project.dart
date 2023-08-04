import 'dart:io';

import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/read_imports_file.dart';

class AddFile {
  static Names names = Names();

  static void save(
    String fileName,
    String content, {
    String extension = 'dart',
    bool allowUpdates = false,
  }) {
    final projectDir = Directory.current;
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
    if (!file.existsSync() || allowUpdates) {
      file.writeAsStringSync(content);
    }
  }

  static void searchAndAddFile(String fileName, String content) {
    final name =
        '${names.camelCaseToUnderscore(fileName.split('/').last)}.dart';
    if (!Imports.filesInDir('lib').contains(name)) {
      save(fileName, content);
    }
  }

  static String path(String fileName) {
    return (fileName.split('/')..removeLast()).join('/');
  }
}
