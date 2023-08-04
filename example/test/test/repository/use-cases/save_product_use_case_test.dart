import 'package:eitherx/eitherx.dart';
import 'package:example/core/failure.dart';
import 'dart:io';import 'dart:convert';import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/test/repository/use-cases/save_product_use_case.dart';
import 'package:example/test/repository/requests/save_product_request.dart';
import 'package:example/test/repository/data-source/settings_remote_data_source_repository.dart';

import 'save_product_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRemoteDataSourceRepository>(),
])
void main() {
late SaveProductUseCase saveProductUseCase;
late SettingsRemoteDataSourceRepository repository;
late InvalidType success;
late Failure failure;
setUp(() {
repository = MockSettingsRemoteDataSourceRepository();
saveProductUseCase = SaveProductUseCase(repository);
failure = Failure(1, 'message');
success = InvalidType(
message: 'message',
success: true,
data: InvalidType.fromJson(jsonDecode(File('test/expected/expected_invalid_type.json').readAsStringSync())),);
});

webService() => repository.saveProduct(productId: "productId",type: "type",);

group('SaveProductUseCase ', () {
test('saveProduct FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await saveProductUseCase.execute(
request: const SaveProductRequest(productId: "productId",type: "type",));
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('saveProduct SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => Right(success));
final res = await saveProductUseCase.execute(
request: SaveProductRequest(productId: "productId",type: "type",));
expect(res.right((data) {}), success);
verify(webService());
verifyNoMoreInteractions(repository);
});
});
}
