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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/test/settings_remote_data_source.dart';
import 'package:example/test/repository/data-source/settings_remote_data_source_repository_impl.dart';
import 'package:example/test/repository/data-source/settings_remote_data_source_repository.dart';
import 'package:example/core/framework/network.dart';

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
late double getSavedProductsResponse;
late double doubles;
late BaseResponse<InvalidType> getSettingsResponse;
late BaseResponse<InvalidType> getSengsResponse;
late BaseResponse<List<InvalidType>?> getQuestionsResponse;
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
getSavedProductsResponse = double(
message: 'message',
success: true,
data: double.fromJson(fromJson('expected_double')),);
doubles = double.fromJson(fromJson('expected_double'));
///[GetSettings]
getSettingsResponse = BaseResponse<InvalidType>(
message: 'message',
success: true,
data: InvalidType.fromJson(fromJson('expected_invalid_type')),);
///[GetSengs]
getSengsResponse = BaseResponse<InvalidType>(
message: 'message',
success: true,
data: InvalidType.fromJson(fromJson('expected_invalid_type')),);
///[GetQuestions]
getQuestionsResponse = BaseResponse<List<InvalidType>?>(
message: 'message',
success: true,
data: List.generate(
2,
(index) =>
InvalidType.fromJson(fromJson('expected_invalid_type')),
));
});
saveProduct() => dataSource.saveProduct(productId: "productId",type: "type",);
getSavedProducts() => dataSource.getSavedProducts(page: 2,limit: 2,);
cacheSavedProducts() => sharedPreferences.setString('SAVEDPRODUCTS',
jsonEncode(double.toJson()),);

getCacheSavedProducts() => sharedPreferences.getString('SAVEDPRODUCTS');

getSettings() => dataSource.getSettings();
getSengs() => dataSource.getSengs();
getQuestions() => dataSource.getQuestions();
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

///[cacheSavedProducts Test]
test('cacheSavedProducts', () async {
when(cacheSavedProducts()).thenAnswer((realInvocation) async => true);
final res = await repository.cacheSavedProducts(data:doubles);
expect(res.rightOrNull(), unit);
verify(cacheSavedProducts());
verifyNoMoreInteractions(sharedPreferences);
});

///[getCacheSavedProducts Test]
test('getCacheSavedProducts', () async {
when(getCacheSavedProducts()).thenAnswer((realInvocation) => 
jsonEncode(double.toJson()),);

final res = repository.getCacheSavedProducts();
expect(res.rightOrNull(),isA<double>());
verify(getCacheSavedProducts());
verifyNoMoreInteractions(sharedPreferences);
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

///[getSengs Success Test]
test('getSengs Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(getSengs())
.thenAnswer((realInvocation) async => getSengsResponse);
final res = await repository.getSengs();
expect(res.rightOrNull(), getSengsResponse);
verify(networkInfo.isConnected);
verify(getSengs());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getSengs Failure Test]
test('getSengs Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(getSengs())
.thenAnswer((realInvocation) async => getSengsResponse);
final res = await repository.getSengs();
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(getSengs());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getQuestions Success Test]
test('getQuestions Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(getQuestions())
.thenAnswer((realInvocation) async => getQuestionsResponse);
final res = await repository.getQuestions();
expect(res.rightOrNull(), getQuestionsResponse);
verify(networkInfo.isConnected);
verify(getQuestions());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getQuestions Failure Test]
test('getQuestions Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(getQuestions())
.thenAnswer((realInvocation) async => getQuestionsResponse);
final res = await repository.getQuestions();
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(getQuestions());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

});
}

///[FromJson]
Map<String, dynamic> fromJson(String path) {
 return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
