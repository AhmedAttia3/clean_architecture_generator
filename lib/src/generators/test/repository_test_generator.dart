import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:generators/formatter/method_format.dart';
import 'package:generators/formatter/names.dart';
import 'package:source_gen/source_gen.dart';

import '../../model_visitor.dart';

class RepositoryTestGenerator
    extends GeneratorForAnnotation<RepositoryTestAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final visitor = ModelVisitor();
    final names = Names();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);

    final classBuffer = StringBuffer();
    final remoteDataSourceName = names.firstLower(visitor.className);
    final remoteDataSourceType = names.firstUpper(visitor.className);

    for (var method in visitor.useCases) {
      final useCaseUnitTestType = '${names.firstUpper(method.name)}UseCase';
      final useCaseUnitTestName = '${names.firstLower(method.name)}UseCase';
      final type = methodFormat.returnType(method.type);
      classBuffer.writeln('@GenerateNiceMocks([');
      classBuffer.writeln('MockSpec<$remoteDataSourceType>(),');
      classBuffer.writeln('MockSpec<NetworkInfo>()');
      classBuffer.writeln('])');
      classBuffer.writeln('void main() {');
      classBuffer.writeln('late $useCaseUnitTestType $useCaseUnitTestName;');
      classBuffer.writeln('late $remoteDataSourceType $remoteDataSourceName;');
      classBuffer.writeln('late APICall apiCall;');
      classBuffer.writeln('late NetworkInfo networkInfo;');
      classBuffer.writeln('late $type successResponse;');
      classBuffer.writeln('setUp(() {');
      classBuffer
          .writeln('$remoteDataSourceName = Mock$remoteDataSourceType();');
      classBuffer.writeln('networkInfo = MockNetworkInfo();');
      classBuffer.writeln('apiCall = APICall(networkInfo);');
      classBuffer.writeln('$useCaseUnitTestName = $useCaseUnitTestType(');
      classBuffer.writeln('addressesRemoteDataSource,');
      classBuffer.writeln('apiCall,);');
      classBuffer.writeln('successResponse = $type(');
      classBuffer.writeln('success:true,');
      classBuffer.writeln('message:"message",');
      if (type.contains('List')) {
        final modelName = names.modelName(type);
        classBuffer.writeln("data: List.generate(2, (index) {");
        classBuffer.writeln(
            "return $modelName.fromJson(Encode.set('path-of-response-file'));");
        classBuffer.writeln("}),");
        classBuffer.writeln(");");
        classBuffer.writeln("});");
      } else {
        classBuffer.writeln("data: null,);");
        classBuffer.writeln("});");
      }
      classBuffer.writeln("webService() =>");
      classBuffer.writeln("$remoteDataSourceName.execute(");
      classBuffer.writeln(
          "${methodFormat.passingParametersWithInitValues(method.parameters)});");

      classBuffer
          .writeln("group('${names.firstUpper(method.name)} USECASE', () {");
      classBuffer.writeln("test('No Internet', () async {");
      classBuffer.writeln(
          "when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);");
      classBuffer.writeln(
          "final res = await $useCaseUnitTestName.execute(${methodFormat.passingParametersWithInitValues(method.parameters)});");
      classBuffer.writeln('expect(res.left((data) {}), isA<Failure>());');
      classBuffer.writeln('verify(networkInfo.isConnected);');
      classBuffer.writeln('verifyNoMoreInteractions(networkInfo);');
      classBuffer.writeln('});');
      classBuffer
          .writeln("test('${names.firstUpper(method.name)}', () async {");
      classBuffer.writeln(
          "when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);");
      classBuffer.writeln(
          "when(webService()).thenAnswer((realInvocation) async => successResponse);");
      classBuffer.writeln(
          "final res = await $useCaseUnitTestName.execute(${methodFormat.passingParametersWithInitValues(method.parameters)});");
      classBuffer.writeln("expect(res.right((data) {}), successResponse);");
      classBuffer.writeln("verify(networkInfo.isConnected);");
      classBuffer.writeln("verify(webService());");
      classBuffer.writeln("verifyNoMoreInteractions(networkInfo);");
      classBuffer.writeln("verifyNoMoreInteractions($remoteDataSourceName);");
      classBuffer.writeln("});");
      classBuffer.writeln("});");

      classBuffer.writeln('}');
    }
    return classBuffer.toString();
  }
}
