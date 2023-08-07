import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:clean_architecture_generator/clean_architecture_generator.dart';
import 'package:clean_architecture_generator/formatter/method_format.dart';
import 'package:clean_architecture_generator/formatter/names.dart';
import 'package:clean_architecture_generator/src/imports_file.dart';
import 'package:source_gen/source_gen.dart';

import '../add_file_to_project.dart';
import '../model_visitor.dart';

class RemoteDataSourceGenerator
    extends GeneratorForAnnotation<ArchitectureAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final path =
        "${AddFile.getDirectories(buildStep.inputId.path)}/data/data-sources";
    final visitor = ModelVisitor();
    final names = Names();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);

    final fileName = visitor.className;
    final remoteDataSource = StringBuffer();

    List<String> imports = [];
    for (var method in visitor.useCases) {
      final returnType = methodFormat.returnType(method.type);
      final type = methodFormat.responseType(returnType);
      if (method.requestType == RequestType.Body) {
        final request = names.requestType(method.name);
        imports.add(request);
      }
      imports.add(type);
    }

    ///[Imports]
    remoteDataSource.writeln(
      Imports.create(
        libs: [
          "import 'package:dio/dio.dart';\n",
          "import 'package:retrofit/retrofit.dart';\n",
          "part '${names.camelCaseToUnderscore(fileName)}.g.dart';\n"
        ],
        imports: imports..add("base_response"),
      ),
    );

    remoteDataSource.writeln(" @RestApi()");
    remoteDataSource.writeln(" abstract class $fileName {");
    remoteDataSource.writeln(" factory $fileName(Dio dio, {String baseUrl}) =");
    remoteDataSource.writeln(" _$fileName;");

    for (var method in visitor.useCases) {
      remoteDataSource
          .writeln("     @${method.methodType.name}('${method.endPoint}')");
      remoteDataSource.writeln("     ${method.type} ${method.name}({");
      if (method.requestType == RequestType.Fields) {
        for (var param in method.requestParameters) {
          remoteDataSource.writeln(
              "         @${param.type.name}('${param.key}') ${param.isRequired ? "required" : ""} ${param.dataType.name} ${param.name},");
        }
      } else {
        final request = names.requestType(method.name);
        remoteDataSource.writeln("         @Body() required $request request,");
      }
      remoteDataSource.writeln("     });");
    }

    remoteDataSource.writeln(" }");

    AddFile.save(
      '$path/$fileName',
      remoteDataSource.toString(),
      allowUpdates: true,
    );

    return "";
  }
}
