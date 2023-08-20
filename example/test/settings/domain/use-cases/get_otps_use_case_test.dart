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
import 'package:example/settings/domain/use-cases/get_otps_use_case.dart';
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

import 'get_otps_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRepository>(),
])
void main() {
late GetOTPsUseCase getOTPsUseCase;
late SettingsRepository repository;
late BaseResponse<List<OtpModel>?> success;
late Failure failure;
late GetOTPsRequest getOTPsRequest;
setUp(() {
repository = MockSettingsRepository();
getOTPsUseCase = GetOTPsUseCase(repository);
failure = Failure(1, 'message');
success = BaseResponse<List<OtpModel>?>(
message: 'message',
success: true,
data: List.generate(
2,
(index) =>
OtpModel.fromJson(json('expected_otp_model')),
));
});

getOTPsRequest = GetOTPsRequest(page: 0,limit: 0,userId: "userId",);

webService() => repository.getOTPs(page: 0,limit: 0,userId: "userId",);

group('GetOTPsUseCase ', () {
test('getOTPs FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await getOTPsUseCase.execute(
request: getOTPsRequest);
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('getOTPs SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => Right(success));
final res = await getOTPsUseCase.execute(
request: getOTPsRequest);
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
