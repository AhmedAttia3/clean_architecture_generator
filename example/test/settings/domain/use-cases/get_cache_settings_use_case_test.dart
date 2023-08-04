import 'package:eitherx/eitherx.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/core/failure.dart';
import 'dart:io';import 'dart:convert';import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:example/core/fold.dart';
import 'package:example/core/safe_request_handler.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/domain/use-cases/get_cache_settings_use_case.dart';
import 'package:example/settings/domain/repository/settings_remote_data_source_repository.dart';

import 'get_cache_settings_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRemoteDataSourceRepository>(),
])
void main() {
late GetCacheSettingsUseCase getCacheSettingsUseCase;
late SettingsRemoteDataSourceRepository repository;
late SettingsModel success;
late Failure failure;
setUp(() {
repository = MockSettingsRemoteDataSourceRepository();
getCacheSettingsUseCase = GetCacheSettingsUseCase(repository);
failure = Failure(1, 'message');
success = SettingsModel.fromJson(jsonDecode(File('test/expected/expected_settings_model.json').readAsStringSync()));
});

webService() => repository.getCacheSettings();

group('GetCacheSettingsUseCase ', () {
test('getCacheSettings FAILURE', ()  {
when(webService()).thenAnswer((realInvocation) => Left(failure));
final res = getCacheSettingsUseCase.execute();
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('getCacheSettings SUCCESS', () {
when(webService()).thenAnswer((realInvocation) => Right(success));
final res = getCacheSettingsUseCase.execute();
expect(res.right((data) {}), success);
verify(webService());
verifyNoMoreInteractions(repository);
});
});
}
