import 'package:eitherx/eitherx.dart';
import 'package:example/core/failure.dart';
import 'dart:io';import 'dart:convert';import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/test/repository/use-cases/get_cache_saved_products_use_case.dart';
import 'package:example/test/repository/data-source/settings_remote_data_source_repository.dart';

import 'get_cache_saved_products_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRemoteDataSourceRepository>(),
])
void main() {
late GetCacheSavedProductsUseCase getCacheSavedProductsUseCase;
late SettingsRemoteDataSourceRepository repository;
late double success;
late Failure failure;
setUp(() {
repository = MockSettingsRemoteDataSourceRepository();
getCacheSavedProductsUseCase = GetCacheSavedProductsUseCase(repository);
failure = Failure(1, 'message');
success = double.fromJson(jsonDecode(File('test/expected/expected_double.json').readAsStringSync()));
});

webService() => repository.getCacheSavedProducts();

group('GetCacheSavedProductsUseCase ', () {
test('getCacheSavedProducts FAILURE', ()  {
when(webService()).thenAnswer((realInvocation) => Left(failure));
final res = getCacheSavedProductsUseCase.execute();
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('getCacheSavedProducts SUCCESS', () {
when(webService()).thenAnswer((realInvocation) => Right(success));
final res = getCacheSavedProductsUseCase.execute();
expect(res.right((data) {}), success);
verify(webService());
verifyNoMoreInteractions(repository);
});
});
}
