import 'dart:convert';
import 'dart:io';

import 'package:eitherx/eitherx.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/use-cases/get_cache_update_user_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mwidgets/mwidgets.dart';

import 'get_cache_update_user_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HomeRepository>(),
])
void main() {
  late GetCacheUpdateUserUseCase getCacheUpdateUserUseCase;
  late HomeRepository repository;
  late DeviceSettingsModel success;
  late Failure failure;
  setUp(() {
    repository = MockHomeRepository();
    getCacheUpdateUserUseCase = GetCacheUpdateUserUseCase(repository);
    failure = Failure(1, 'message');
    success =
        DeviceSettingsModel.fromJson(json('expected_device_settings_model'));
  });

  webService() => repository.getCacheUpdateUser();

  group('GetCacheUpdateUserUseCase ', () {
    test('getCacheUpdateUser FAILURE', () {
      when(webService()).thenAnswer((realInvocation) => Left(failure));
      final res = getCacheUpdateUserUseCase.execute();
      expect(res.left((data) {}), failure);
      verify(webService());
      verifyNoMoreInteractions(repository);
    });

    test('getCacheUpdateUser SUCCESS', () {
      when(webService()).thenAnswer((realInvocation) => Right(success));
      final res = getCacheUpdateUserUseCase.execute();
      expect(res.right((data) {}), success);
      verify(webService());
      verifyNoMoreInteractions(repository);
    });
  });
}

///[FromJson]
Map<String, dynamic> json(String path) {
  return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
