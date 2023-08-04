import 'package:eitherx/eitherx.dart';
import 'package:example/core/failure.dart';
import 'dart:io';import 'dart:convert';import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/test/repository/use-cases/get_saved_products_use_case.dart';
import 'package:example/test/repository/requests/get_saved_products_request.dart';
import 'package:example/test/repository/data-source/settings_remote_data_source_repository.dart';

import 'get_saved_products_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRemoteDataSourceRepository>(),
])
void main() {
late GetSavedProductsUseCase getSavedProductsUseCase;
late SettingsRemoteDataSourceRepository repository;
late double success;
late Failure failure;
setUp(() {
repository = MockSettingsRemoteDataSourceRepository();
getSavedProductsUseCase = GetSavedProductsUseCase(repository);
failure = Failure(1, 'message');
success = double(
message: 'message',
success: true,
data: double.fromJson(jsonDecode(File('test/expected/expected_double.json').readAsStringSync())),);
});

webService() => repository.getSavedProducts(page: 2,limit: 2,);

group('GetSavedProductsUseCase ', () {
test('getSavedProducts FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await getSavedProductsUseCase.execute(
request: const GetSavedProductsRequest(page: 2,limit: 2,));
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('getSavedProducts SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => Right(success));
final res = await getSavedProductsUseCase.execute(
request: GetSavedProductsRequest(page: 2,limit: 2,));
expect(res.right((data) {}), success);
verify(webService());
verifyNoMoreInteractions(repository);
});
});
}
