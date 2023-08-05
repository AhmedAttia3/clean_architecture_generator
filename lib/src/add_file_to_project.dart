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
    _saveOrUpdate(
      fileName,
      content,
      allowUpdates: allowUpdates,
      extension: extension,
    );
  }

  static Future<void> move(String fileName, String path, String oldPath) async {
    final dataSource_old = File('$oldPath/$fileName.dart');
    final dataSource = File('$path/$fileName.dart');

    final content = await dataSource_old.readAsString();
    await dataSource.writeAsString(content);

    await dataSource_old.delete();
  }

  static String createPath(
    String fileName, {
    String extension = 'dart',
  }) {
    final projectDir = Directory.current;
    final name = "${names.camelCaseToUnderscore(fileName)}.$extension";
    return '${projectDir.path}/$name';
  }

  static String? search(String fileName) {
    final name = names.camelCaseToUnderscore(fileName.split('/').last);
    return Imports.importPath('$name.dart');
  }

  static String getDirectories(String fileName) {
    return (fileName.split('/')..removeLast()).join('/');
  }

  static void searchAndAddFile(String fileName, String content) {
    final path = search(fileName);
    if (path == null) {
      save(fileName, content);
    }
  }

  static _saveOrUpdate(
    String path,
    String content, {
    bool allowUpdates = false,
    String extension = 'dart',
  }) {
    final import = search(path);
    if (import == null) {
      path = createPath(path, extension: extension);

      ///[To handle files when move remote to data-source folder]
      if (!path.contains('local_data_source') &&
          path.contains('data/data-sources/')) {
        path = path.replaceFirst("data/data-sources/", "");
      }
      final dir = Directory(getDirectories(path));
      if (!dir.existsSync()) {
        try {
          dir.createSync();
        } catch (e) {
          final paths = getDirectories(path).split('/');
          String exist = '';
          for (var path in paths) {
            exist += '$path/';
            final dir = Directory(exist);
            if (dir.existsSync()) continue;
            dir.createSync();
          }
        }
      }

      final file = File(path);
      if (!file.existsSync() || allowUpdates) {
        file.writeAsStringSync(content);
      }
    } else {
      final file = File(import);
      if (allowUpdates) file.writeAsStringSync(content);
    }
  }
}
