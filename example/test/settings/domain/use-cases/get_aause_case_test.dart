import 'dart:convert';
import 'dart:io';

import 'package:eitherx/eitherx.dart';
import 'package:example/core/failure.dart';
import 'package:example/core/fold.dart';
import 'package:example/settings/domain/repository/settings_remote_data_source_repository.dart';
import 'package:example/settings/domain/use-cases/get_aause_case.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_aause_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SettingsRemoteDataSourceRepository>(),
])
void main() {
  late GetAAUseCase getAAUseCase;
  late SettingsRemoteDataSourceRepository repository;
  late BaseResponse<int> success;
  late Failure failure;
  setUp(() {
    repository = MockSettingsRemoteDataSourceRepository();
    getAAUseCase = GetAAUseCase(repository);
    failure = Failure(1, 'message');
    success = BaseResponse<int>(
      message: 'message',
      success: true,
      data: int.fromJson(jsonDecode(
          File('test/expected/expected_int.json').readAsStringSync())),
    );
  });

  webService() => repository.getAA();

  group('GetAAUseCase ', () {
    test('getAA FAILURE', () async {
      when(webService()).thenAnswer((realInvocation) async => Left(failure));
      final res = await getAAUseCase.execute();
      expect(res.left((data) {}), failure);
      verify(webService());
      verifyNoMoreInteractions(repository);
    });

    test('getAA SUCCESS', () async {
      when(webService()).thenAnswer((realInvocation) async => Right(success));
      final res = await getAAUseCase.execute();
      expect(res.right((data) {}), success);
      verify(webService());
      verifyNoMoreInteractions(repository);
    });
  });
}
