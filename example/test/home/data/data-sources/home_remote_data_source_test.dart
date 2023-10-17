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
import 'package:example/home/data/client-services/home_client_services.dart';
import 'package:example/home/data/data-sources/home_remote_data_source.dart';
import 'package:example/home/data/data-sources/home_remote_data_source_impl.dart';
import 'package:example/home/data/data-sources/home_remote_data_source.dart';
import 'package:example/core/base/safe_request_handler.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/network.dart';
import 'package:example/home/data/models/governorate_model.dart';
import 'package:example/home/domain/requests/get_result_request.dart';
import 'package:example/home/data/models/result_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';

import 'home_remote_data_source_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<HomeClientServices>(),
MockSpec<NetworkInfo>(),
])
void main() {
late HomeClientServices dataSource;
late HomeRemoteDataSource remoteDataSource;
late Failure failure;
late SafeApi apiCall;
late NetworkInfo networkInfo;
late BaseResponse<List<GovernorateModel>?> getGovernoratesResponse;
late BaseResponse<ResultModel?> getResultResponse;
late BaseResponse<int> addFavoriteResponse;
late BaseResponse<DeviceSettingsModel?> updateUserResponse;
setUp(() {
failure = Failure(999,"Cache failure");
networkInfo = MockNetworkInfo();
apiCall = SafeApi(networkInfo);
dataSource = MockHomeClientServices();
remoteDataSource = HomeRemoteDataSourceImplement(
dataSource,
apiCall,
);
///[GetGovernorates]
getGovernoratesResponse = BaseResponse<List<GovernorateModel>?>(
message: 'message',
success: true,
data: List.generate(
2,
(index) =>
GovernorateModel.fromJson(json('expected_governorate_model')),
));
///[GetResult]
getResultResponse = BaseResponse<ResultModel?>(
message: 'message',
success: true,
data: ResultModel.fromJson(json('expected_result_model')),);
///[AddFavorite]
addFavoriteResponse = BaseResponse<int>(
message: 'message',
success: true,
data: 0,);
///[UpdateUser]
updateUserResponse = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
});
getGovernorates() => dataSource.getGovernorates();
getResult() => dataSource.getResult(countryId: 0,termId: 0,studentName: "studentName",sittingNumber: "sittingNumber",);
addFavorite() => dataSource.addFavorite(countryId: 0,);
updateUser() => dataSource.updateUser(firebaseToken: 0,);
group('HomeRemoteDataSource RemoteDataSource', () {
///[No Internet Test]
test('No Internet', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
final res = await remoteDataSource.getGovernorates();
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verifyNoMoreInteractions(networkInfo);
});

///[getGovernorates Success Test]
test('getGovernorates Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(getGovernorates())
.thenAnswer((realInvocation) async => getGovernoratesResponse);
final res = await remoteDataSource.getGovernorates();
expect(res.rightOrNull(), getGovernoratesResponse);
verify(networkInfo.isConnected);
verify(getGovernorates());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getGovernorates Failure Test]
test('getGovernorates Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(getGovernorates())
.thenAnswer((realInvocation) async => getGovernoratesResponse);
final res = await remoteDataSource.getGovernorates();
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(getGovernorates());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getResult Success Test]
test('getResult Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(getResult())
.thenAnswer((realInvocation) async => getResultResponse);
final res = await remoteDataSource.getResult(countryId: 0,termId: 0,studentName: "studentName",sittingNumber: "sittingNumber",);
expect(res.rightOrNull(), getResultResponse);
verify(networkInfo.isConnected);
verify(getResult());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getResult Failure Test]
test('getResult Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(getResult())
.thenAnswer((realInvocation) async => getResultResponse);
final res = await remoteDataSource.getResult(countryId: 0,termId: 0,studentName: "studentName",sittingNumber: "sittingNumber",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(getResult());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addFavorite Success Test]
test('addFavorite Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(addFavorite())
.thenAnswer((realInvocation) async => addFavoriteResponse);
final res = await remoteDataSource.addFavorite(countryId: 0,);
expect(res.rightOrNull(), addFavoriteResponse);
verify(networkInfo.isConnected);
verify(addFavorite());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addFavorite Failure Test]
test('addFavorite Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(addFavorite())
.thenAnswer((realInvocation) async => addFavoriteResponse);
final res = await remoteDataSource.addFavorite(countryId: 0,);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(addFavorite());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[updateUser Success Test]
test('updateUser Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(updateUser())
.thenAnswer((realInvocation) async => updateUserResponse);
final res = await remoteDataSource.updateUser(firebaseToken: 0,);
expect(res.rightOrNull(), updateUserResponse);
verify(networkInfo.isConnected);
verify(updateUser());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[updateUser Failure Test]
test('updateUser Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(updateUser())
.thenAnswer((realInvocation) async => updateUserResponse);
final res = await remoteDataSource.updateUser(firebaseToken: 0,);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(updateUser());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

});
}

///[FromJson]
Map<String, dynamic> json(String path) {
 return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
