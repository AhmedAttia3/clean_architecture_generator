import 'dart:convert';
import 'dart:io';

import 'package:eitherx/eitherx.dart';
import 'package:example/home/data/data-sources/home_local_data_source.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/repository/home_repository_impl.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mwidgets/mwidgets.dart';

import 'home_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HomeLocalDataSource>(),
])
void main() {
  late HomeRepository repository;
  late Failure failure;
  late HomeLocalDataSource homeLocalDataSource;
  late DeviceSettingsModel deviceSettingsModels;
  setUp(() {
    failure = Failure(999, "Cache failure");
    homeLocalDataSource = MockHomeLocalDataSource();
    repository = HomeRepositoryImplement(
      homeLocalDataSource,
    );
    deviceSettingsModels =
        DeviceSettingsModel.fromJson(json('expected_device_settings_model'));
  });
  cacheUpdateUser() =>
      homeLocalDataSource.cacheUpdateUser(data: deviceSettingsModels);

  getCacheUpdateUser() => homeLocalDataSource.getCacheUpdateUser();

  group('HomeRepository Repository', () {
    ///[cacheUpdateUser Success]
    test('cacheUpdateUser', () async {
      when(cacheUpdateUser())
          .thenAnswer((realInvocation) async => const Right(unit));
      final res = await repository.cacheUpdateUser(data: deviceSettingsModels);
      expect(res.rightOrNull(), unit);
      verify(cacheUpdateUser());
      verifyNoMoreInteractions(homeLocalDataSource);
    });

    ///[cacheUpdateUser Failure]
    test('cacheUpdateUser', () async {
      when(cacheUpdateUser())
          .thenAnswer((realInvocation) async => Left(failure));
      final res = await repository.cacheUpdateUser(data: deviceSettingsModels);
      expect(res.leftOrNull(), isA<Failure>());
      verify(cacheUpdateUser());
      verifyNoMoreInteractions(homeLocalDataSource);
    });

    ///[getCacheUpdateUser Success]
    test('getCacheUpdateUser', () async {
      when(getCacheUpdateUser())
          .thenAnswer((realInvocation) => Right(deviceSettingsModels));

      final res = repository.getCacheUpdateUser();
      expect(res.rightOrNull(), isA<DeviceSettingsModel>());
      verify(getCacheUpdateUser());
      verifyNoMoreInteractions(homeLocalDataSource);
    });

    ///[getCacheUpdateUser Failure]
    test('getCacheUpdateUser', () async {
      when(getCacheUpdateUser()).thenAnswer((realInvocation) => Left(failure));

      final res = repository.getCacheUpdateUser();
      expect(res.leftOrNull(), isA<Failure>());
      verify(getCacheUpdateUser());
      verifyNoMoreInteractions(homeLocalDataSource);
    });
  });
}

///[FromJson]
Map<String, dynamic> json(String path) {
  return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
