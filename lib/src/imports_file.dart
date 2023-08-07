import 'dart:io';

import 'package:clean_architecture_generator/formatter/names.dart';

class Imports {
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

  static String create({
    List<String> imports = const [],
    List<String> libs = const [],
    bool hasCache = false,
    bool isTest = false,
    bool isCubit = false,
    bool isPaging = false,
    bool isRepo = false,
    bool isLocalDataSource = false,
    bool isUseCase = false,
  }) {
    final names = Names();
    String data = "import 'package:eitherx/eitherx.dart';\n";
    final baseResponse = importName('base_response.dart');
    if (baseResponse != null) data += baseResponse;
    final failure = importName('failure.dart');
    if (failure != null) data += failure;
    if (isTest) {
      data += "import 'dart:io';";
      data += "import 'dart:convert';";
      data += "import 'package:flutter_test/flutter_test.dart';\n";
      data += "import 'package:mockito/mockito.dart';\n";
      data += "import 'package:mockito/annotations.dart';\n";
      final fold = importName('fold.dart');
      if (fold != null) data += fold;
      final safeRequest = importName('safe_request_handler.dart');
      if (safeRequest != null) data += safeRequest;
    } else {
      data += "import 'package:injectable/injectable.dart';\n";
    }
    final baseUseCase = importName('base_use_case.dart');
    if (baseUseCase != null) data += baseUseCase;
    if (isCubit) {
      data += "import 'package:flutter/material.dart';\n";
      data += "import 'package:flutter_bloc/flutter_bloc.dart';\n";
      final states = importName('states.dart');
      if (states != null) data += states;
      final fold = importName('fold.dart');
      if (fold != null) data += fold;
      final stateRenderer = importName('state_renderer.dart');
      if (stateRenderer != null) data += stateRenderer;
    }
    if (isPaging) {
      data += "import 'package:flutter_pagewise/flutter_pagewise.dart';";
    }
    if (isUseCase) {
      data += "import 'dart:ffi';\n";
    }
    if (isRepo) {
      data += "import 'dart:convert';";
      final safeRequest = importName('safe_request_handler.dart');
      if (safeRequest != null) data += safeRequest;
    }
    if (isLocalDataSource) {
      data += "import 'dart:convert';";
      data += "import 'package:shared_preferences/shared_preferences.dart';\n";
    }
    if (hasCache) {
      data += "import 'package:shared_preferences/shared_preferences.dart';\n";
    }
    for (var path in imports) {
      if (path.isEmpty) continue;
      final res = names.camelCaseToUnderscore(path);
      final import = importName('$res.dart');
      if (import != null) data += import;
    }
    for (var path in libs) {
      if (path.isEmpty) continue;
      data += path;
    }
    return data;
  }

  static String? importName(String subName) {
    final files = libFiles;
    final index = files.indexWhere((item) {
      final path = item.split('/').last;
      return path.contains(subName) && path.length <= subName.length + 2;
    });
    if (index != -1) {
      return "import 'package:${files[index].replaceAll('\\', '/').replaceFirst('lib', parent)}';\n";
    }
    return null;
  }

  static String? importPath(String subName) {
    final files = libFiles;
    final index = files.indexWhere((item) => item.contains(subName));
    if (index != -1) {
      return files[index];
    }
    return null;
  }

  static List<String> get libFiles {
    return filesInDir('lib');
  }

  static List<String> filesInDir(String path) {
    List<String> data = [];
    if (path.contains('.dart')) {
      return data..add(path);
    } else if (path.contains('.')) {
      return data;
    } else {
      final files = Directory(path);
      if (files.listSync().isEmpty) {
        return data;
      } else {
        final filePaths = files.listSync().map((e) => e.path).toList();
        for (var filePath in filePaths) {
          data.addAll(filesInDir(filePath));
        }
        return data;
      }
    }
  }

  static String base(String baseFilePath) {
    final projectDir = Directory.current;
    final parent = projectDir.absolute.uri.path.split('/');
    return "${parent.elementAt(parent.length - 2)}${(baseFilePath.split('/')..removeLast()).join('/')}"
        .replaceFirst('lib', '');
  }

  static String get parent {
    final projectDir = Directory.current;
    final parent = projectDir.absolute.uri.path.split('/');
    return parent.elementAt(parent.length - 2).replaceFirst('lib', '');
  }
}
