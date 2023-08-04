import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/annotations.dart';
import 'package:source_gen/source_gen.dart';

import '../add_file_to_project.dart';
import '../model_visitor.dart';
import '../read_imports_file.dart';

class LocalDataSourceGenerator
    extends GeneratorForAnnotation<ArchitectureAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final path = "${AddFile.path(buildStep.inputId.path)}/data/data-source";
    final visitor = ModelVisitor();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);

    final localDataSourceType = names.localDataSourceType(visitor.className);
    final localDataSourceName = names.firstLower(localDataSourceType);
    final localDataSourceImplType =
        "${names.firstUpper(localDataSourceType)}Impl";
    final localDataSourceImplName = names.firstLower(localDataSourceImplType);

    final dataSource = StringBuffer();
    final dataSourceImpl = StringBuffer();

    ///[Imports]
    dataSource.writeln(Imports.create(
      imports: [],
      filePath: buildStep.inputId.path,
      isLocalDataSource: true,
    ));
    dataSource.writeln('///[Implementation]');
    dataSource.writeln('abstract class $localDataSourceType {');
    for (var method in visitor.useCases) {
      final type = methodFormat.returnType(method.type);
      final responseDataType = names.responseDataType(type);

      ///[cache save or get]
      if (method.isCache) {
        final useCaseName =
            names.firstUpper(method.name).replaceFirst('Get', '');
        dataSource.writeln(
            'Future<Either<Failure, Unit>> cache$useCaseName({required $responseDataType data,});');
        dataSource.writeln(
            'Either<Failure, $responseDataType> getCache$useCaseName();');
      }
    }

    dataSource.writeln('}\n');

    AddFile.save(
      '$path/$localDataSourceType',
      dataSource.toString(),
      allowUpdates: true,
    );

    ///[Imports]
    dataSourceImpl.writeln(Imports.create(
      imports: [localDataSourceName],
      filePath: buildStep.inputId.path,
      isLocalDataSource: true,
    ));

    dataSourceImpl.writeln('///[$localDataSourceImplType]');
    dataSourceImpl.writeln('///[Implementation]');
    dataSourceImpl.writeln('@Injectable(as:$localDataSourceType)');
    dataSourceImpl.writeln(
        'class $localDataSourceImplType implements $localDataSourceType {');
    dataSourceImpl.writeln('final SharedPreferences sharedPreferences;');
    dataSourceImpl.writeln('const $localDataSourceImplType(');
    dataSourceImpl.writeln('this.sharedPreferences,');
    dataSourceImpl.writeln(');\n');
    for (var method in visitor.useCases) {
      final type = methodFormat.returnType(method.type);
      final responseDataType = names.responseDataType(type);
      final modelName = names.baseModelName(type);

      ///[cache save or get implement]
      if (method.isCache) {
        final useCaseName =
            names.firstUpper(method.name).replaceFirst('Get', '');
        final key = names.firstLower(useCaseName);
        dataSourceImpl.writeln('final _$key = "${key.toUpperCase()}";');

        ///[cache]
        dataSourceImpl.writeln('@override');
        dataSourceImpl.writeln(
            'Future<Either<Failure, Unit>> cache$useCaseName({required $responseDataType data,}) async {');
        dataSourceImpl.writeln('try {');
        final cachedType = _cacheType(responseDataType);
        final dynamicType = cachedType == 'dynamic';
        if (dynamicType) {
          if (responseDataType.contains('List')) {
            dataSourceImpl.writeln(
                'await sharedPreferences.setString(_$key,jsonEncode(data.map((item)=> item.toJson()).toList()));');
          } else {
            dataSourceImpl.writeln(
                'await sharedPreferences.setString(_$key, jsonEncode(data.toJson()));');
          }
        } else {
          dataSourceImpl.writeln(
              'await sharedPreferences.set${names.firstUpper(cachedType)}(_$key, data);');
        }
        dataSourceImpl.writeln('return const Right(unit);');
        dataSourceImpl.writeln('} catch (e) {');
        dataSourceImpl.writeln("return Left(Failure(12, 'Cash failure'));");
        dataSourceImpl.writeln('}');
        dataSourceImpl.writeln('}\n');

        ///[get]
        dataSourceImpl.writeln('@override');
        dataSourceImpl.writeln(
            'Either<Failure, $responseDataType> getCache$useCaseName(){');
        dataSourceImpl.writeln('try {');
        if (dynamicType) {
          dataSourceImpl.writeln(
              "final res = sharedPreferences.getString(_$key) ?? '{}';");
          if (responseDataType.contains('List')) {
            dataSourceImpl.writeln("$responseDataType data = [];");
            dataSourceImpl.writeln("for (var item in jsonDecode(res)) {");
            dataSourceImpl.writeln("data.add($modelName.fromJson(item));");
            dataSourceImpl.writeln("}");
            dataSourceImpl.writeln("return Right(data);");
          } else {
            dataSourceImpl
                .writeln("return Right($modelName.fromJson(jsonDecode(res)));");
          }
        } else {
          dataSourceImpl.writeln(
              "final res = sharedPreferences.get${names.firstUpper(cachedType)}(_$key) ?? '';");
          dataSourceImpl.writeln('return Right(res);');
        }
        dataSourceImpl.writeln('} catch (e) {');
        dataSourceImpl.writeln("return Left(Failure(12, 'Cash failure'));");
        dataSourceImpl.writeln('}');
        dataSourceImpl.writeln('}\n');
      }
    }

    dataSourceImpl.writeln('}\n');

    AddFile.save(
      '$path/$localDataSourceImplName',
      dataSourceImpl.toString(),
      allowUpdates: true,
    );

    dataSource.writeln(dataSourceImpl);

    return dataSource.toString();
  }

  String _cacheType(dynamic type) {
    if (type.runtimeType is int ||
        type.runtimeType is String ||
        type.runtimeType is bool ||
        type.runtimeType is double) {
      return type.toString();
    }
    return 'dynamic';
  }
}
