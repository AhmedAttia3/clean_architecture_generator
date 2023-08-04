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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/settings/settings_remote_data_source.dart';
import 'package:example/settings/data/repository/settings_remote_data_source_repository_impl.dart';
import 'package:example/settings/domain/repository/settings_remote_data_source_repository.dart';
import 'package:example/core/network.dart';

import 'settings_remote_data_source_repository_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRemoteDataSource>(),
MockSpec<NetworkInfo>(),
MockSpec<SharedPreferences>(),
])
void main() {
late SettingsRemoteDataSource dataSource;
late SettingsRemoteDataSourceRepository repository;
late SafeApi apiCall;
late NetworkInfo networkInfo;
late SharedPreferences sharedPreferences;
late BaseResponse<dynamic> saveProductResponse;
late BaseResponse<ProductModel?> getSavedProductsResponse;
late BaseResponse<SettingsModel?> getSettingsResponse;
late SettingsModel settingsModels;
setUp(() {
sharedPreferences = MockSharedPreferences();
networkInfo = MockNetworkInfo();
apiCall = SafeApi(networkInfo);
dataSource = MockSettingsRemoteDataSource();
repository = SettingsRemoteDataSourceRepositoryImplement(
dataSource,
apiCall,
sharedPreferences,
);
///[SaveProduct]
saveProductResponse = BaseResponse<dynamic>(
message: 'message',
success: true,
data: null,);
///[GetSavedProducts]
getSavedProductsResponse = BaseResponse<ProductModel?>(
message: 'message',
success: true,
data: ProductModel.fromJson(fromJson('expected_product_model')),);
///[GetSettings]
getSettingsResponse = BaseResponse<SettingsModel?>(
message: 'message',
success: true,
data: SettingsModel.fromJson(fromJson('expected_settings_model')),);
settingsModels = SettingsModel.fromJson(fromJson('expected_settings_model'));
});
saveProduct() => dataSource.saveProduct(productId: "productId",type: "type",);
getSavedProducts() => dataSource.getSavedProducts(page: 2,limit: 2,);
getSettings() => dataSource.getSettings();
cacheSettings() => sharedPreferences.setString('SETTINGS',
jsonEncode(SettingsModel.toJson()),);

getCacheSettings() => sharedPreferences.getString('SETTINGS');

group('SettingsRemoteDataSourceRepository Repository', () {
///[No Internet Test]
test('No Internet', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
final res = await repository.saveProduct(productId: "productId",type: "type",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verifyNoMoreInteractions(networkInfo);
});

///[saveProduct Success Test]
test('saveProduct Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(saveProduct())
.thenAnswer((realInvocation) async => saveProductResponse);
final res = await repository.saveProduct(productId: "productId",type: "type",);
expect(res.rightOrNull(), saveProductResponse);
verify(networkInfo.isConnected);
verify(saveProduct());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[saveProduct Failure Test]
test('saveProduct Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(saveProduct())
.thenAnswer((realInvocation) async => saveProductResponse);
final res = await repository.saveProduct(productId: "productId",type: "type",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(saveProduct());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getSavedProducts Success Test]
test('getSavedProducts Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(getSavedProducts())
.thenAnswer((realInvocation) async => getSavedProductsResponse);
final res = await repository.getSavedProducts(page: 2,limit: 2,);
expect(res.rightOrNull(), getSavedProductsResponse);
verify(networkInfo.isConnected);
verify(getSavedProducts());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getSavedProducts Failure Test]
test('getSavedProducts Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(getSavedProducts())
.thenAnswer((realInvocation) async => getSavedProductsResponse);
final res = await repository.getSavedProducts(page: 2,limit: 2,);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(getSavedProducts());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getSettings Success Test]
test('getSettings Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(getSettings())
.thenAnswer((realInvocation) async => getSettingsResponse);
final res = await repository.getSettings();
expect(res.rightOrNull(), getSettingsResponse);
verify(networkInfo.isConnected);
verify(getSettings());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getSettings Failure Test]
test('getSettings Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(getSettings())
.thenAnswer((realInvocation) async => getSettingsResponse);
final res = await repository.getSettings();
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(getSettings());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[cacheSettings Test]
test('cacheSettings', () async {
when(cacheSettings()).thenAnswer((realInvocation) async => true);
final res = await repository.cacheSettings(data:settingsModels);
expect(res.rightOrNull(), unit);
verify(cacheSettings());
verifyNoMoreInteractions(sharedPreferences);
});

///[getCacheSettings Test]
test('getCacheSettings', () async {
when(getCacheSettings()).thenAnswer((realInvocation) => 
jsonEncode(SettingsModel.toJson()),);

final res = repository.getCacheSettings();
expect(res.rightOrNull(),isA<SettingsModel>());
verify(getCacheSettings());
verifyNoMoreInteractions(sharedPreferences);
});

});
}

///[FromJson]
Map<String, dynamic> fromJson(String path) {
 return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
