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
import 'package:example/settings/domain/use-cases/get_addresses_use_case.dart';
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

import 'get_addresses_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRepository>(),
])
void main() {
late GetAddressesUseCase getAddressesUseCase;
late SettingsRepository repository;
late BaseResponse<List<AddressModel>?> success;
late Failure failure;
late GetAddressesRequest getAddressesRequest;
setUp(() {
repository = MockSettingsRepository();
getAddressesUseCase = GetAddressesUseCase(repository);
failure = Failure(1, 'message');
success = BaseResponse<List<AddressModel>?>(
message: 'message',
success: true,
data: List.generate(
2,
(index) =>
AddressModel.fromJson(json('expected_address_model')),
));
});

getAddressesRequest = GetAddressesRequest(page: 0,limit: 0,userId: "userId",);

webService() => repository.getAddresses(page: 0,limit: 0,userId: "userId",);

group('GetAddressesUseCase ', () {
test('getAddresses FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await getAddressesUseCase.execute(
request: getAddressesRequest);
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('getAddresses SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => Right(success));
final res = await getAddressesUseCase.execute(
request: getAddressesRequest);
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
