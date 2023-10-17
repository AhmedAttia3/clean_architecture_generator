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
import 'package:example/home/domain/use-cases/update_user_use_case.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/data/models/governorate_model.dart';
import 'package:example/home/domain/requests/get_result_request.dart';
import 'package:example/home/data/models/result_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/core/base/base_response.dart';

import 'update_user_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<HomeRepository>(),
])
void main() {
late UpdateUserUseCase updateUserUseCase;
late HomeRepository repository;
late BaseResponse<DeviceSettingsModel?> success;
late Failure failure;
setUp(() {
repository = MockHomeRepository();
updateUserUseCase = UpdateUserUseCase(repository);
failure = Failure(1, 'message');
success = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
});

webService() => repository.updateUser(firebaseToken: 0,);

group('UpdateUserUseCase ', () {
test('updateUser FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await updateUserUseCase.execute(
request: 0);
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('updateUser SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => Right(success));
final res = await updateUserUseCase.execute(
request: 0);
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
