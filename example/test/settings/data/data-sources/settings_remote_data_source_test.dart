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
import 'package:example/settings/data/client-services/settings_client_services.dart';
import 'package:example/settings/data/data-sources/settings_remote_data_source.dart';
import 'package:example/settings/data/data-sources/settings_remote_data_source_impl.dart';
import 'package:example/settings/data/data-sources/settings_remote_data_source.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/network.dart';
import 'package:example/core/failure.dart';
import 'package:example/settings/domain/requests/login_request.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/domain/requests/register_request.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/domain/requests/get_addresses_request.dart';
import 'package:example/settings/data/models/address_model.dart';
import 'package:example/settings/domain/requests/get_otps_request.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/settings/domain/requests/get_otp_request.dart';
import 'package:example/settings/data/models/otp_model.dart';

import 'settings_remote_data_source_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsClientServices>(),
MockSpec<NetworkInfo>(),
])
void main() {
late SettingsClientServices dataSource;
late SettingsRemoteDataSource remoteDataSource;
late Failure failure;
late SafeApi apiCall;
late NetworkInfo networkInfo;
late BaseResponse<UserModel?> loginResponse;
late LoginRequest loginRequest;
late BaseResponse<UserModel?> registerResponse;
late BaseResponse<List<AddressModel>?> getAddressesResponse;
late BaseResponse<List<OtpModel>?> getOTPsResponse;
late BaseResponse<List<OtpModel>?> getOtpResponse;
setUp(() {
failure = Failure(999,"Cache failure");
networkInfo = MockNetworkInfo();
apiCall = SafeApi(networkInfo);
dataSource = MockSettingsClientServices();
remoteDataSource = SettingsRemoteDataSourceImplement(
dataSource,
apiCall,
);
///[Login]
loginResponse = BaseResponse<UserModel?>(
message: 'message',
success: true,
data: UserModel.fromJson(json('expected_user_model')),);
///[Register]
registerResponse = BaseResponse<UserModel?>(
message: 'message',
success: true,
data: UserModel.fromJson(json('expected_user_model')),);
///[GetAddresses]
getAddressesResponse = BaseResponse<List<AddressModel>?>(
message: 'message',
success: true,
data: List.generate(
2,
(index) =>
AddressModel.fromJson(json('expected_address_model')),
));
///[GetOTPs]
getOTPsResponse = BaseResponse<List<OtpModel>?>(
message: 'message',
success: true,
data: List.generate(
2,
(index) =>
OtpModel.fromJson(json('expected_otp_model')),
));
///[GetOtp]
getOtpResponse = BaseResponse<List<OtpModel>?>(
message: 'message',
success: true,
data: List.generate(
2,
(index) =>
OtpModel.fromJson(json('expected_otp_model')),
));
});
loginRequest = LoginRequest(email: "email",password: "password",);
login() => dataSource.login(
request : loginRequest,);
register() => dataSource.register(fullName: "fullName",phone: "phone",email: "email",password: "password",id: "id",);
getAddresses() => dataSource.getAddresses(page: 0,limit: 0,userId: "userId",);
getOTPs() => dataSource.getOTPs(page: 0,limit: 0,userId: "userId",);
getOtp() => dataSource.getOtp(page: 0,limit: 0,userId: "userId",);
group('SettingsRemoteDataSource RemoteDataSource', () {
///[No Internet Test]
test('No Internet', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
final res = await remoteDataSource.login(request: loginRequest);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verifyNoMoreInteractions(networkInfo);
});

///[login Success Test]
test('login Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(login())
.thenAnswer((realInvocation) async => loginResponse);
final res = await remoteDataSource.login(request: loginRequest);
expect(res.rightOrNull(), loginResponse);
verify(networkInfo.isConnected);
verify(login());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[login Failure Test]
test('login Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(login())
.thenAnswer((realInvocation) async => loginResponse);
final res = await remoteDataSource.login(request: loginRequest);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(login());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[register Success Test]
test('register Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(register())
.thenAnswer((realInvocation) async => registerResponse);
final res = await remoteDataSource.register(fullName: "fullName",phone: "phone",email: "email",password: "password",id: "id",);
expect(res.rightOrNull(), registerResponse);
verify(networkInfo.isConnected);
verify(register());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[register Failure Test]
test('register Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(register())
.thenAnswer((realInvocation) async => registerResponse);
final res = await remoteDataSource.register(fullName: "fullName",phone: "phone",email: "email",password: "password",id: "id",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(register());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getAddresses Success Test]
test('getAddresses Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(getAddresses())
.thenAnswer((realInvocation) async => getAddressesResponse);
final res = await remoteDataSource.getAddresses(page: 0,limit: 0,userId: "userId",);
expect(res.rightOrNull(), getAddressesResponse);
verify(networkInfo.isConnected);
verify(getAddresses());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getAddresses Failure Test]
test('getAddresses Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(getAddresses())
.thenAnswer((realInvocation) async => getAddressesResponse);
final res = await remoteDataSource.getAddresses(page: 0,limit: 0,userId: "userId",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(getAddresses());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getOTPs Success Test]
test('getOTPs Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(getOTPs())
.thenAnswer((realInvocation) async => getOTPsResponse);
final res = await remoteDataSource.getOTPs(page: 0,limit: 0,userId: "userId",);
expect(res.rightOrNull(), getOTPsResponse);
verify(networkInfo.isConnected);
verify(getOTPs());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getOTPs Failure Test]
test('getOTPs Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(getOTPs())
.thenAnswer((realInvocation) async => getOTPsResponse);
final res = await remoteDataSource.getOTPs(page: 0,limit: 0,userId: "userId",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(getOTPs());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getOtp Success Test]
test('getOtp Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(getOtp())
.thenAnswer((realInvocation) async => getOtpResponse);
final res = await remoteDataSource.getOtp(page: 0,limit: 0,userId: "userId",);
expect(res.rightOrNull(), getOtpResponse);
verify(networkInfo.isConnected);
verify(getOtp());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[getOtp Failure Test]
test('getOtp Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(getOtp())
.thenAnswer((realInvocation) async => getOtpResponse);
final res = await remoteDataSource.getOtp(page: 0,limit: 0,userId: "userId",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(getOtp());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

});
}

///[FromJson]
Map<String, dynamic> json(String path) {
 return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
