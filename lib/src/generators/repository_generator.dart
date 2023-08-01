import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:generators/formatter/method_format.dart';
import 'package:generators/formatter/names.dart';
import 'package:source_gen/source_gen.dart';

import '../add_file_to_project.dart';
import '../model_visitor.dart';
import '../read_imports_file.dart';

class RepositoryGenerator extends GeneratorForAnnotation<RepositoryAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final path = "${AddFile.path(buildStep.inputId.path)}/repository";
    final visitor = ModelVisitor();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);

    final classBuffer = StringBuffer();
    final clientService = names.firstLower(visitor.className);

    final repositoryName = '${names.firstUpper(visitor.className)}Repository';
    final repositoryNameImplement = '${repositoryName}Implement';

    classBuffer.writeln(imports(baseFilePath: buildStep.inputId.path));
    classBuffer.writeln('///[$repositoryName]');
    classBuffer.writeln('abstract class $repositoryName {');
    bool hasCache = false;
    for (var method in visitor.useCases) {
      final useCaseName = names.firstLower(method.name);
      final type = methodFormat.returnType(method.type);
      classBuffer.writeln(
          'Future<Either<Failure, $type>> $useCaseName(${methodFormat.parameters(method.parameters)});');

      ///[cache save or get]
      if (method.comment?.contains('///cache') == true) {
        hasCache = true;
        final useCaseName = names.firstUpper(method.name);
        classBuffer.writeln(
            'Future<Either<Failure, Unit>> cache$useCaseName({required $type data});');
        classBuffer.writeln('Either<Failure, $type> get$useCaseName();');
      }
    }
    classBuffer.writeln('}\n');

    AddFile.save('$path/$repositoryName', classBuffer.toString());
    final content = StringBuffer();
    content.writeln(imports(
      repositoryName: repositoryName,
      hasCache: hasCache,
      baseFilePath: buildStep.inputId.path,
    ));
    content.writeln('///[$repositoryName implementation]');
    content.writeln('@Injectable(as:$repositoryName)');
    content
        .writeln('class $repositoryNameImplement implements $repositoryName {');
    content.writeln('final ${visitor.className} $clientService;');
    content.writeln('final SafeApi api;');

    ///[add cache]
    if (hasCache) {
      content.writeln('final SharedPreferences sharedPreferences;');
    }
    content.writeln('const $repositoryNameImplement(');
    content.writeln('this.$clientService,');
    content.writeln('this.api,');

    ///[add cache]
    if (hasCache) {
      content.writeln('this.sharedPreferences,');
    }
    content.writeln(');\n');
    for (var method in visitor.useCases) {
      final useCaseName = names.firstLower(method.name);
      final type = methodFormat.returnType(method.type);
      content.writeln('@override');
      content.writeln(
          'Future<Either<Failure, $type>> $useCaseName(${methodFormat.parameters(method.parameters)})async {');
      content.writeln('return await api<$type>(');

      content.writeln(
          'apiCall: $clientService.${method.name}(${methodFormat.passingParameters(method.parameters)}),);');
      content.writeln('}\n');

      ///[cache save or get implement]
      if (method.comment?.contains('///cache') == true) {
        final useCaseName = names.firstUpper(method.name);
        final key = names.firstLower(useCaseName);
        content.writeln('final _$key = "${key.toUpperCase()}";');

        ///[cache]
        content.writeln('@override');
        content.writeln(
            'Future<Either<Failure, Unit>> cache$useCaseName({required $type data}) async {');
        content.writeln('try {');
        final cachedType = _cacheType(type);
        final dynamicType = cachedType == 'dynamic';
        if (dynamicType) {
          content.writeln(
              'await sharedPreferences.setString(_$key, jsonEncode(data.toJson()));');
        } else {
          content.writeln(
              'await sharedPreferences.set${names.firstUpper(cachedType)}(_$key, data);');
        }
        content.writeln('return const Right(unit);');
        content.writeln('} catch (e) {');
        content.writeln("return Left(Failure(12, 'Cash failure'));");
        content.writeln('}');
        content.writeln('}\n');

        ///[get]
        content.writeln('@override');
        content.writeln('Either<Failure, $type> get$useCaseName(){');
        content.writeln('try {');
        if (dynamicType) {
          content
              .writeln("final res = sharedPreferences.getString(_$key) ?? '';");
          content
              .writeln("return Right($cachedType.fromJson(jsonDecode(res)));");
        } else {
          content.writeln(
              "final res = sharedPreferences.get${names.firstUpper(cachedType)}(_$key) ?? '';");
          content.writeln('return Right(res);');
        }
        content.writeln('} catch (e) {');
        content.writeln("return Left(Failure(12, 'Cash failure'));");
        content.writeln('}');
        content.writeln('}\n');
      }
    }
    content.writeln('}\n');
    AddFile.save('$path/${repositoryName}Impl', content.toString());
    classBuffer.write(content);
    return classBuffer.toString();
  }

  String _cacheType(dynamic type) {
    if (type is int || type is String || type is bool || type is double) {
      return type.toString();
    }
    return 'dynamic';
  }

  String imports({
    required String baseFilePath,
    String repositoryName = '',
    bool hasCache = false,
  }) {
    String data = ReadImports.file(baseFilePath);
    data += "import 'package:eitherx/eitherx.dart';\n";
    data += "import 'package:injectable/injectable.dart';\n";
    if (hasCache) {
      data += "import 'package:shared_preferences/shared_preferences.dart';\n";
    }
    if (repositoryName.isNotEmpty) {
      data +=
          "import './${names.camelCaseToUnderscore(repositoryName)}.dart';\n";
      data +=
          "import '../${names.camelCaseToUnderscore(repositoryName.replaceFirst('Repository', ''))}.dart';\n";
    }
    return data;
  }
}
