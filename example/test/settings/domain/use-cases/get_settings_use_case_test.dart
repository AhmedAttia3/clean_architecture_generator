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
import 'package:example/settings/domain/use-cases/get_settings_use_case.dart';
import 'package:example/settings/domain/repository/settings_remote_data_source_repository.dart';

import 'get_settings_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRemoteDataSourceRepository>(),
])
void main() {
late GetSettingsUseCase getSettingsUseCase;
late SettingsRemoteDataSourceRepository repository;
late BaseResponse<SettingsModel?> success;
late Failure failure;
setUp(() {
repository = MockSettingsRemoteDataSourceRepository();
getSettingsUseCase = GetSettingsUseCase(repository);
failure = Failure(1, 'message');
success = BaseResponse<SettingsModel?>(
message: 'message',
success: true,
data: SettingsModel.fromJson(jsonDecode(File('test/expected/expected_settings_model.json').readAsStringSync())),);
});

webService() => repository.getSettings();

group('GetSettingsUseCase ', () {
test('getSettings FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await getSettingsUseCase.execute(
);
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('getSettings SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => Right(success));
final res = await getSettingsUseCase.execute(
);
expect(res.right((data) {}), success);
verify(webService());
verifyNoMoreInteractions(repository);
});
});
}
