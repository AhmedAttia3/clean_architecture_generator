import 'package:eitherx/eitherx.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/core/failure.dart';
import 'dart:io';import 'dart:convert';import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:example/core/fold.dart';
import 'package:example/core/safe_request_handler.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/domain/use-cases/get_app_use_case.dart';
import 'package:example/settings/domain/requests/get_app_request.dart';
import 'package:example/settings/domain/repository/settings_remote_data_source_repository.dart';

import 'get_app_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRemoteDataSourceRepository>(),
])
void main() {
late GetAppUseCase getAppUseCase;
late SettingsRemoteDataSourceRepository repository;
late BaseResponse<List<SettingsModel>?> success;
late Failure failure;
setUp(() {
repository = MockSettingsRemoteDataSourceRepository();
getAppUseCase = GetAppUseCase(repository);
failure = Failure(1, 'message');
success = BaseResponse<List<SettingsModel>?>(
message: 'message',
success: true,
data: List.generate(
2,
(index) =>
SettingsModel.fromJson(jsonDecode(File('test/expected/expected_settings_model.json').readAsStringSync())),
));
});

webService() => repository.getApp(page: 2,limit: 2,);

group('GetAppUseCase ', () {
test('getApp FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await getAppUseCase.execute(
request: const GetAppRequest(page: 2,limit: 2,));
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('getApp SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => Right(success));
final res = await getAppUseCase.execute(
request: const GetAppRequest(page: 2,limit: 2,));
expect(res.right((data) {}), success);
verify(webService());
verifyNoMoreInteractions(repository);
});
});
}
