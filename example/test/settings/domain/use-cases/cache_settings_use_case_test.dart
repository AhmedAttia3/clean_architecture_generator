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
import 'package:example/settings/domain/use-cases/cache_settings_use_case.dart';
import 'package:example/settings/domain/repository/settings_remote_data_source_repository.dart';

import 'cache_settings_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRemoteDataSourceRepository>(),
])
void main() {
late CacheSettingsUseCase cacheSettingsUseCase;
late SettingsRemoteDataSourceRepository repository;
late SettingsModel data;
late Failure failure;
setUp(() {
repository = MockSettingsRemoteDataSourceRepository();
cacheSettingsUseCase = CacheSettingsUseCase(repository);
failure = Failure(1, 'message');
data = SettingsModel.fromJson(jsonDecode(File('test/expected/expected_settings_model.json').readAsStringSync()));
});

webService() => repository.cacheSettings(data: data);

group('CacheSettingsUseCase ', () {
test('cacheSettings FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await cacheSettingsUseCase.execute(request: data);
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('cacheSettings SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => const Right(unit));
final res = await cacheSettingsUseCase.execute(request: data);
expect(res.right((data) {}), unit);
verify(webService());
verifyNoMoreInteractions(repository);
});
});
}
