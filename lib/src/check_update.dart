import 'dart:io';

class CheckUpdate {
  static String fileContent({
    required String content,
    required String path,
    List<String> methods = const [],
  }) {
    String lastContent = File(path).readAsStringSync();

    String oldContent = cropContent(lastContent);
    content = cropContent(content);

    final splits1 = content.split('\n');

    final diff = StringBuffer();
    for (var line in splits1) {
      if (!oldContent.contains(line)) {
        diff.writeln(line);
      }
    }

    final index = lastContent.lastIndexOf("}");
    lastContent = lastContent.substring(0, index);

    final result = StringBuffer();
    result.writeln(lastContent);
    result.writeln(diff);

    result.writeln("//${methods.map((e) => e).toList().toString()}");
    result.writeln("}");

    return result.toString();
  }

  static String cropContent(String content) {
    final firstIndex = content.indexOf("{");
    final lastIndex = content.lastIndexOf("}");
    return content.substring(firstIndex, lastIndex);
  }
}
