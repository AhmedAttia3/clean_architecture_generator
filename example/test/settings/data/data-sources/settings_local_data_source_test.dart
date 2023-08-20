import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:example/core/fold.dart';
import 'package:example/core/safe_request_handler.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/data/data-sources/settings_local_data_source.dart';
import 'package:example/settings/data/data-sources/settings_local_data_source_impl.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_local_data_source_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SharedPreferences>(),
])
void main() {
late SettingsLocalDataSource settingsLocalDataSource;
late SharedPreferences sharedPreferences;
late UserModel userModelCache;
setUp(() {
sharedPreferences = MockSharedPreferences();
settingsLocalDataSource = SettingsLocalDataSourceImpl(
sharedPreferences,
);
userModelCache = UserModel.fromJson(json('expected_user_model'));
userModelCache = UserModel.fromJson(json('expected_user_model'));
});
const _login = 'LOGIN';
cacheLogin() => sharedPreferences.setString(_login,
jsonEncode(userModelCache.toJson()),);

getCacheLogin() => sharedPreferences.getString(_login);

const _register = 'REGISTER';
cacheRegister() => sharedPreferences.setString(_register,
jsonEncode(userModelCache.toJson()),);

getCacheRegister() => sharedPreferences.getString(_register);

group('SettingsLocalDataSource', () {
///[cacheLogin Test]
test('cacheLogin', () async {
when(cacheLogin()).thenAnswer((realInvocation) async => true);
final res = await settingsLocalDataSource.cacheLogin(data:userModelCache);
expect(res.rightOrNull(), unit);
verify(cacheLogin());
verifyNoMoreInteractions(sharedPreferences);
});

///[getCacheLogin Test]
test('getCacheLogin', () async {
when(getCacheLogin()).thenAnswer((realInvocation) => 
jsonEncode(userModelCache.toJson()),);

final res = settingsLocalDataSource.getCacheLogin();
expect(res.rightOrNull(),isA<UserModel>());
verify(getCacheLogin());
verifyNoMoreInteractions(sharedPreferences);
});

///[cacheRegister Test]
test('cacheRegister', () async {
when(cacheRegister()).thenAnswer((realInvocation) async => true);
final res = await settingsLocalDataSource.cacheRegister(data:userModelCache);
expect(res.rightOrNull(), unit);
verify(cacheRegister());
verifyNoMoreInteractions(sharedPreferences);
});

///[getCacheRegister Test]
test('getCacheRegister', () async {
when(getCacheRegister()).thenAnswer((realInvocation) => 
jsonEncode(userModelCache.toJson()),);

final res = settingsLocalDataSource.getCacheRegister();
expect(res.rightOrNull(),isA<UserModel>());
verify(getCacheRegister());
verifyNoMoreInteractions(sharedPreferences);
});

});
}

///[FromJson]
Map<String, dynamic> json(String path) {
 return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
