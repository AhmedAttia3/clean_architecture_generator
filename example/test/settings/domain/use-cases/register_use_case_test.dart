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
import 'package:example/settings/domain/use-cases/register_use_case.dart';
import 'package:example/settings/domain/repository/settings_repository.dart';
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
import 'package:example/core/base_response.dart';

import 'register_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRepository>(),
])
void main() {
late RegisterUseCase registerUseCase;
late SettingsRepository repository;
late BaseResponse<UserModel?> success;
late Failure failure;
late RegisterRequest registerRequest;
setUp(() {
repository = MockSettingsRepository();
registerUseCase = RegisterUseCase(repository);
failure = Failure(1, 'message');
success = BaseResponse<UserModel?>(
message: 'message',
success: true,
data: UserModel.fromJson(json('expected_user_model')),);
});

registerRequest = RegisterRequest(fullName: "fullName",phone: "phone",email: "email",password: "password",id: "id",);

webService() => repository.register(fullName: "fullName",phone: "phone",email: "email",password: "password",id: "id",);

group('RegisterUseCase ', () {
test('register FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await registerUseCase.execute(
request: registerRequest);
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('register SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => Right(success));
final res = await registerUseCase.execute(
request: registerRequest);
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
