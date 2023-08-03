import 'package:eitherx/eitherx.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/failure.dart';
import 'dart:io';import 'dart:convert';import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:example/core/consts/fold.dart';
import 'package:example/core/cubit/safe_request_handler.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/test/repository/use-cases/cache_saved_products_use_case.dart';
import 'package:example/test/repository/data-source/settings_remote_data_source_repository.dart';

import 'cache_saved_products_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRemoteDataSourceRepository>(),
])
void main() {
late CacheSavedProductsUseCase cacheSavedProductsUseCase;
late SettingsRemoteDataSourceRepository repository;
late double data;
late Failure failure;
setUp(() {
repository = MockSettingsRemoteDataSourceRepository();
cacheSavedProductsUseCase = CacheSavedProductsUseCase(repository);
failure = Failure(1, 'message');
data = double.fromJson(jsonDecode(File('test/expected/expected_double.json').readAsStringSync()));
webService() => repository.cacheSavedProducts(data: data);
group('CacheSavedProductsUseCase ', () {
test('cacheSavedProducts FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await cacheSavedProductsUseCase.execute(request: data);
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('cacheSavedProducts SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => const Right(unit));
final res = await cacheSavedProductsUseCase.execute(request: data);
expect(res.right((data) {}), unit);
verify(webService());
verifyNoMoreInteractions(repository);
});
});
}
