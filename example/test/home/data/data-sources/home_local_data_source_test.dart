import 'dart:convert';
import 'dart:io';

import 'package:eitherx/eitherx.dart';
import 'package:example/home/data/data-sources/home_local_data_source.dart';
import 'package:example/home/data/data-sources/home_local_data_source_impl.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_local_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SharedPreferences>(),
])
void main() {
  late HomeLocalDataSource homeLocalDataSource;
  late SharedPreferences sharedPreferences;
  late DeviceSettingsModel deviceSettingsModelCache;
  setUp(() {
    sharedPreferences = MockSharedPreferences();
    homeLocalDataSource = HomeLocalDataSourceImpl(
      sharedPreferences,
    );
    deviceSettingsModelCache =
        DeviceSettingsModel.fromJson(json('expected_device_settings_model'));
  });
  const _updateUser = 'UPDATEUSER';
  cacheUpdateUser() => sharedPreferences.setString(
        _updateUser,
        jsonEncode(deviceSettingsModelCache.toJson()),
      );

  getCacheUpdateUser() => sharedPreferences.getString(_updateUser);

  group('HomeLocalDataSource', () {
    ///[cacheUpdateUser Test]
    test('cacheUpdateUser', () async {
      when(cacheUpdateUser()).thenAnswer((realInvocation) async => true);
      final res = await homeLocalDataSource.cacheUpdateUser(
          data: deviceSettingsModelCache);
      expect(res.rightOrNull(), unit);
      verify(cacheUpdateUser());
      verifyNoMoreInteractions(sharedPreferences);
    });

    ///[getCacheUpdateUser Test]
    test('getCacheUpdateUser', () async {
      when(getCacheUpdateUser()).thenAnswer(
        (realInvocation) => jsonEncode(deviceSettingsModelCache.toJson()),
      );

      final res = homeLocalDataSource.getCacheUpdateUser();
      expect(res.rightOrNull(), isA<DeviceSettingsModel>());
      verify(getCacheUpdateUser());
      verifyNoMoreInteractions(sharedPreferences);
    });
  });
}

///[FromJson]
Map<String, dynamic> json(String path) {
  return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
