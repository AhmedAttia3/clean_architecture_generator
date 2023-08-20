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
import 'package:example/settings/data/data-sources/settings_remote_data_source.dart';
import 'package:example/settings/data/repository/settings_repository_impl.dart';
import 'package:example/settings/domain/repository/settings_repository.dart';
import 'package:example/core/base_response.dart';
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

import 'settings_repository_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRemoteDataSource>(),
MockSpec<SettingsLocalDataSource>(),
])
void main() {
late SettingsRemoteDataSource dataSource;
late SettingsRepository repository;
late Failure failure;
late SettingsLocalDataSource settingsLocalDataSource;
late BaseResponse<UserModel?> loginResponse;
late LoginRequest loginRequest;
late UserModel userModels;
late BaseResponse<UserModel?> registerResponse;
late RegisterRequest registerRequest;
late BaseResponse<List<AddressModel>?> getAddressesResponse;
late GetAddressesRequest getAddressesRequest;
late BaseResponse<List<OtpModel>?> getOTPsResponse;
late GetOTPsRequest getOTPsRequest;
late BaseResponse<List<OtpModel>?> getOtpResponse;
late GetOtpRequest getOtpRequest;
setUp(() {
failure = Failure(999,"Cache failure");
settingsLocalDataSource = MockSettingsLocalDataSource();
dataSource = MockSettingsRemoteDataSource();
repository = SettingsRepositoryImplement(
dataSource,
settingsLocalDataSource,
);
///[Login]
loginResponse = BaseResponse<UserModel?>(
message: 'message',
success: true,
data: UserModel.fromJson(json('expected_user_model')),);
userModels = UserModel.fromJson(json('expected_user_model'));
///[Register]
registerResponse = BaseResponse<UserModel?>(
message: 'message',
success: true,
data: UserModel.fromJson(json('expected_user_model')),);
userModels = UserModel.fromJson(json('expected_user_model'));
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
login() => dataSource.login(request: loginRequest);
cacheLogin() => settingsLocalDataSource.cacheLogin(data : userModels);

getCacheLogin() => settingsLocalDataSource.getCacheLogin();

register() => dataSource.register(fullName: "fullName",phone: "phone",email: "email",password: "password",id: "id",);
cacheRegister() => settingsLocalDataSource.cacheRegister(data : userModels);

getCacheRegister() => settingsLocalDataSource.getCacheRegister();

getAddresses() => dataSource.getAddresses(page: 0,limit: 0,userId: "userId",);
getOTPs() => dataSource.getOTPs(page: 0,limit: 0,userId: "userId",);
getOtp() => dataSource.getOtp(page: 0,limit: 0,userId: "userId",);
group('SettingsRepository Repository', () {
///[login Success Test]
test('login Success', () async {
when(login())
.thenAnswer((realInvocation) async => Right(loginResponse));
final res = await repository.login(request: loginRequest);
expect(res.rightOrNull(), loginResponse);
verify(login());
verifyNoMoreInteractions(dataSource);
});

///[login Failure Test]
test('login Failure', () async {
when(login())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.login(request: loginRequest);
expect(res.leftOrNull(), isA<Failure>());
verify(login());
verifyNoMoreInteractions(dataSource);
});

///[cacheLogin Success]
test('cacheLogin', () async {
when(cacheLogin()).thenAnswer((realInvocation) async => const Right(unit));
final res = await repository.cacheLogin(data:userModels);
expect(res.rightOrNull(), unit);
verify(cacheLogin());
verifyNoMoreInteractions(settingsLocalDataSource);
});

///[cacheLogin Failure]
test('cacheLogin', () async {
when(cacheLogin()).thenAnswer((realInvocation) async => Left(failure));
final res = await repository.cacheLogin(data:userModels);
expect(res.leftOrNull(), isA<Failure>());
verify(cacheLogin());
verifyNoMoreInteractions(settingsLocalDataSource);
});

///[getCacheLogin Success]
test('getCacheLogin', () async {
when(getCacheLogin()).thenAnswer((realInvocation) => Right(userModels));

final res = repository.getCacheLogin();
expect(res.rightOrNull(),isA<UserModel>());
verify(getCacheLogin());
verifyNoMoreInteractions(settingsLocalDataSource);
});

///[getCacheLogin Failure]
test('getCacheLogin', () async {
when(getCacheLogin()).thenAnswer((realInvocation) => Left(failure));

final res = repository.getCacheLogin();
expect(res.leftOrNull(),isA<Failure>());
verify(getCacheLogin());
verifyNoMoreInteractions(settingsLocalDataSource);
});

///[register Success Test]
test('register Success', () async {
when(register())
.thenAnswer((realInvocation) async => Right(registerResponse));
final res = await repository.register(fullName: "fullName",phone: "phone",email: "email",password: "password",id: "id",);
expect(res.rightOrNull(), registerResponse);
verify(register());
verifyNoMoreInteractions(dataSource);
});

///[register Failure Test]
test('register Failure', () async {
when(register())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.register(fullName: "fullName",phone: "phone",email: "email",password: "password",id: "id",);
expect(res.leftOrNull(), isA<Failure>());
verify(register());
verifyNoMoreInteractions(dataSource);
});

///[cacheRegister Success]
test('cacheRegister', () async {
when(cacheRegister()).thenAnswer((realInvocation) async => const Right(unit));
final res = await repository.cacheRegister(data:userModels);
expect(res.rightOrNull(), unit);
verify(cacheRegister());
verifyNoMoreInteractions(settingsLocalDataSource);
});

///[cacheRegister Failure]
test('cacheRegister', () async {
when(cacheRegister()).thenAnswer((realInvocation) async => Left(failure));
final res = await repository.cacheRegister(data:userModels);
expect(res.leftOrNull(), isA<Failure>());
verify(cacheRegister());
verifyNoMoreInteractions(settingsLocalDataSource);
});

///[getCacheRegister Success]
test('getCacheRegister', () async {
when(getCacheRegister()).thenAnswer((realInvocation) => Right(userModels));

final res = repository.getCacheRegister();
expect(res.rightOrNull(),isA<UserModel>());
verify(getCacheRegister());
verifyNoMoreInteractions(settingsLocalDataSource);
});

///[getCacheRegister Failure]
test('getCacheRegister', () async {
when(getCacheRegister()).thenAnswer((realInvocation) => Left(failure));

final res = repository.getCacheRegister();
expect(res.leftOrNull(),isA<Failure>());
verify(getCacheRegister());
verifyNoMoreInteractions(settingsLocalDataSource);
});

///[getAddresses Success Test]
test('getAddresses Success', () async {
when(getAddresses())
.thenAnswer((realInvocation) async => Right(getAddressesResponse));
final res = await repository.getAddresses(page: 0,limit: 0,userId: "userId",);
expect(res.rightOrNull(), getAddressesResponse);
verify(getAddresses());
verifyNoMoreInteractions(dataSource);
});

///[getAddresses Failure Test]
test('getAddresses Failure', () async {
when(getAddresses())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.getAddresses(page: 0,limit: 0,userId: "userId",);
expect(res.leftOrNull(), isA<Failure>());
verify(getAddresses());
verifyNoMoreInteractions(dataSource);
});

///[getOTPs Success Test]
test('getOTPs Success', () async {
when(getOTPs())
.thenAnswer((realInvocation) async => Right(getOTPsResponse));
final res = await repository.getOTPs(page: 0,limit: 0,userId: "userId",);
expect(res.rightOrNull(), getOTPsResponse);
verify(getOTPs());
verifyNoMoreInteractions(dataSource);
});

///[getOTPs Failure Test]
test('getOTPs Failure', () async {
when(getOTPs())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.getOTPs(page: 0,limit: 0,userId: "userId",);
expect(res.leftOrNull(), isA<Failure>());
verify(getOTPs());
verifyNoMoreInteractions(dataSource);
});

///[getOtp Success Test]
test('getOtp Success', () async {
when(getOtp())
.thenAnswer((realInvocation) async => Right(getOtpResponse));
final res = await repository.getOtp(page: 0,limit: 0,userId: "userId",);
expect(res.rightOrNull(), getOtpResponse);
verify(getOtp());
verifyNoMoreInteractions(dataSource);
});

///[getOtp Failure Test]
test('getOtp Failure', () async {
when(getOtp())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.getOtp(page: 0,limit: 0,userId: "userId",);
expect(res.leftOrNull(), isA<Failure>());
verify(getOtp());
verifyNoMoreInteractions(dataSource);
});

});
}

///[FromJson]
Map<String, dynamic> json(String path) {
 return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
