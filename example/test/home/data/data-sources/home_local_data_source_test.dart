import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/data/data-sources/home_local_data_source.dart';
import 'package:example/home/data/data-sources/home_local_data_source_impl.dart';
import 'package:example/home/data/models/device_settings_model.dart';
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
deviceSettingsModelCache = DeviceSettingsModel.fromJson(json('expected_device_settings_model'));
});
const _addComment5 = 'ADDCOMMENT5';
cacheAddComment5() => sharedPreferences.setString(_addComment5,
jsonEncode(deviceSettingsModelCache.toJson()),);

getCacheAddComment5() => sharedPreferences.getString(_addComment5);

group('HomeLocalDataSource', () {
///[cacheAddComment5 Test]
test('cacheAddComment5', () async {
when(cacheAddComment5()).thenAnswer((realInvocation) async => true);
final res = await homeLocalDataSource.cacheAddComment5(data:deviceSettingsModelCache);
expect(res.rightOrNull(), unit);
verify(cacheAddComment5());
verifyNoMoreInteractions(sharedPreferences);
});

///[getCacheAddComment5 Test]
test('getCacheAddComment5', () async {
when(getCacheAddComment5()).thenAnswer((realInvocation) => 
jsonEncode(deviceSettingsModelCache.toJson()),);

final res = homeLocalDataSource.getCacheAddComment5();
expect(res.rightOrNull(),isA<DeviceSettingsModel>());
verify(getCacheAddComment5());
verifyNoMoreInteractions(sharedPreferences);
});

});
}

///[FromJson]
Map<String, dynamic> json(String path) {
 return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
