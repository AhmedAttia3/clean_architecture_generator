import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'dart:io';import 'dart:convert';import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:example/core/fold.dart';
import 'package:example/core/safe_request_handler.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/domain/use-cases/get_saved_products_use_case.dart';
import 'package:example/settings/domain/requests/get_saved_products_request.dart';
import 'package:example/settings/domain/repository/settings_remote_data_source_repository.dart';

import 'get_saved_products_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRemoteDataSourceRepository>(),
])
void main() {
late GetSavedProductsUseCase getSavedProductsUseCase;
late SettingsRemoteDataSourceRepository repository;
late BaseResponse<ProductModel?> success;
late Failure failure;
setUp(() {
repository = MockSettingsRemoteDataSourceRepository();
getSavedProductsUseCase = GetSavedProductsUseCase(repository);
failure = Failure(1, 'message');
success = BaseResponse<ProductModel?>(
message: 'message',
success: true,
data: ProductModel.fromJson(jsonDecode(File('test/expected/expected_product_model.json').readAsStringSync())),);
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
