import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:generators/formatter/method_format.dart';
import 'package:generators/formatter/names.dart';
import 'package:generators/src/add_file_to_project.dart';
import 'package:generators/src/model_visitor.dart';
import 'package:source_gen/source_gen.dart';

class UseCaseGenerator extends GeneratorForAnnotation<UseCaseAnnotation> {
  final names = Names();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final basePath = AddFile.path(buildStep.inputId.path);
    final path = "$basePath/use-cases";
    final visitor = ModelVisitor();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);

    final repositoryName = '${names.firstUpper(visitor.className)}Repository';

    ///[BaseUseCase]
    final baseUseCase = StringBuffer();
    baseUseCase.writeln("import 'package:eitherx/eitherx.dart';");
    baseUseCase.writeln("abstract class BaseUseCase<RES, POS> {");
    baseUseCase.writeln(
        "Future<Either<Failure, RES>> execute({required POS request});");
    baseUseCase.writeln("}");

    AddFile.save('/lib/core/base_use_case', baseUseCase.toString());

    ///[UseCase]
    final classBuffer = StringBuffer();
    for (var method in visitor.useCases) {
      final content = StringBuffer();
      final useCaseName = '${names.firstUpper(method.name)}UseCase';
      final requestName = '${names.firstUpper(method.name)}Request';
      final methodName = names.firstLower(method.name);
      final type = methodFormat.returnType(method.type);
      content.writeln(
          imports(repositoryName: repositoryName, requestName: requestName));
      content.writeln('///[$useCaseName implementation]');
      content.writeln('@injectable');
      content.writeln(
          'class $useCaseName implements BaseUseCase<$type,$requestName>{');
      content.writeln('final $repositoryName repository;');
      content.writeln('const $useCaseName(');
      content.writeln('this.repository,');
      content.writeln(');\n');
      content.writeln('@override');
      content.writeln(
          'Future<Either<Failure, $type>> execute({required $requestName request,}) async {');
      content.writeln('return await repository.$methodName');
      content
          .writeln('(${methodFormat.requestParameters(method.parameters)});');
      content.writeln('}\n');
      content.writeln('}\n');

      AddFile.save('$path/$useCaseName', content.toString());

      ///[cache save or get implement useCases]
      if (method.comment?.contains('///cache') == true) {
        final methodName = names.firstUpper(method.name);

        ///[cache]
        final cacheContent = StringBuffer();
        cacheContent.writeln(imports(repositoryName: repositoryName));
        cacheContent.writeln('///[Cache$useCaseName implementation]');
        cacheContent.writeln('@injectable');
        cacheContent.writeln(
            'class Cache$useCaseName implements BaseUseCase<Unit,$type> {');
        cacheContent.writeln('final $repositoryName repository;');
        cacheContent.writeln('const Cache$useCaseName(');
        cacheContent.writeln('this.repository,');
        cacheContent.writeln(');\n');
        cacheContent.writeln('@override');
        cacheContent.writeln(
            'Future<Either<Failure, Unit>> execute({required $type data,}) async {');
        cacheContent.writeln('return await repository.cache$methodName');
        cacheContent.writeln('(data: this.data);');
        cacheContent.writeln('}\n');
        cacheContent.writeln('}\n');
        content.write(cacheContent);
        AddFile.save('$path/Cache$useCaseName', cacheContent.toString());

        ///[get]
        final getContent = StringBuffer();
        getContent.writeln(imports(repositoryName: repositoryName));
        getContent.writeln('///[Get$useCaseName implementation]');
        getContent.writeln('@injectable');
        getContent.writeln('class Get$useCaseName {');
        getContent.writeln('final $repositoryName repository;');
        getContent.writeln('const Get$useCaseName(');
        getContent.writeln('this.repository,');
        getContent.writeln(');\n');
        getContent.writeln('Either<Failure, $type> execute() {');
        getContent.writeln('return repository.get$methodName();');
        getContent.writeln('}\n');
        getContent.writeln('}\n');
        content.write(getContent);
        AddFile.save('$path/Get$useCaseName', getContent.toString());
      }

      classBuffer.write(content);
    }
    return classBuffer.toString();
  }

  String imports({
    String repositoryName = '',
    String requestName = '',
  }) {
    String data = "import 'package:eitherx/eitherx.dart';\n";
    data += "import 'package:injectable/injectable.dart';\n";
    data += "import '../../core/base_use_case.dart';\n";

    if (requestName.isNotEmpty) {
      data +=
          "import '../requests/${names.camelCaseToUnderscore(requestName)}.dart';\n";
    }
    if (repositoryName.isNotEmpty) {
      data +=
          "import '../repository/${names.camelCaseToUnderscore(repositoryName)}.dart';\n";
    }
    return data;
  }
}
