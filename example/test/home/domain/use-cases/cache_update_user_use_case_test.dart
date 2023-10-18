import 'dart:convert';
import 'dart:io';

import 'package:eitherx/eitherx.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/use-cases/cache_update_user_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mwidgets/mwidgets.dart';

import 'cache_update_user_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HomeRepository>(),
])
void main() {
  late CacheUpdateUserUseCase cacheUpdateUserUseCase;
  late HomeRepository repository;
  late DeviceSettingsModel data;
  late Failure failure;
  setUp(() {
    repository = MockHomeRepository();
    cacheUpdateUserUseCase = CacheUpdateUserUseCase(repository);
    failure = Failure(1, 'message');
    data = DeviceSettingsModel.fromJson(json('expected_device_settings_model'));
  });

  webService() => repository.cacheUpdateUser(data: data);

  group('CacheUpdateUserUseCase ', () {
    test('cacheUpdateUser FAILURE', () async {
      when(webService()).thenAnswer((realInvocation) async => Left(failure));
      final res = await cacheUpdateUserUseCase.execute(request: data);
      expect(res.left((data) {}), failure);
      verify(webService());
      verifyNoMoreInteractions(repository);
    });

    test('cacheUpdateUser SUCCESS', () async {
      when(webService())
          .thenAnswer((realInvocation) async => const Right(unit));
      final res = await cacheUpdateUserUseCase.execute(request: data);
      expect(res.right((data) {}), unit);
      verify(webService());
      verifyNoMoreInteractions(repository);
    });
  });
}

///[FromJson]
Map<String, dynamic> json(String path) {
  return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
