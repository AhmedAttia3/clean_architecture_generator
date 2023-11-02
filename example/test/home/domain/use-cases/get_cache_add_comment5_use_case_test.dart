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
import 'package:example/home/domain/use-cases/get_cache_add_comment5_use_case.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/core/base/base_response.dart';

import 'get_cache_add_comment5_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<HomeRepository>(),
])
void main() {
late GetCacheAddComment5UseCase getCacheAddComment5UseCase;
late HomeRepository repository;
late DeviceSettingsModel success;
late Failure failure;
setUp(() {
repository = MockHomeRepository();
getCacheAddComment5UseCase = GetCacheAddComment5UseCase(repository);
failure = Failure(1, 'message');
success = DeviceSettingsModel.fromJson(json('expected_device_settings_model'));
});

webService() => repository.getCacheAddComment5();

group('GetCacheAddComment5UseCase ', () {
test('getCacheAddComment5 FAILURE', ()  {
when(webService()).thenAnswer((realInvocation) => Left(failure));
final res = getCacheAddComment5UseCase.execute();
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('getCacheAddComment5 SUCCESS', () {
when(webService()).thenAnswer((realInvocation) => Right(success));
final res = getCacheAddComment5UseCase.execute();
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
