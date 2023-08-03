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
import 'package:example/test/repository/use-cases/get_sengs_use_case.dart';
import 'package:example/test/repository/data-source/settings_remote_data_source_repository.dart';

import 'get_sengs_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRemoteDataSourceRepository>(),
])
void main() {
late GetSengsUseCase getSengsUseCase;
late SettingsRemoteDataSourceRepository repository;
late BaseResponse<InvalidType> success;
late Failure failure;
setUp(() {
repository = MockSettingsRemoteDataSourceRepository();
getSengsUseCase = GetSengsUseCase(repository);
failure = Failure(1, 'message');
success = BaseResponse<InvalidType>(
message: 'message',
success: true,
data: InvalidType.fromJson(jsonDecode(File('test/expected/expected_invalid_type.json').readAsStringSync())),);
});

webService() => repository.getSengs();

group('GetSengsUseCase ', () {
test('getSengs FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await getSengsUseCase.execute(
);
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('getSengs SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => Right(success));
final res = await getSengsUseCase.execute(
);
expect(res.right((data) {}), success);
verify(webService());
verifyNoMoreInteractions(repository);
});
});
}
