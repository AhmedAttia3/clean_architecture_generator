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
import 'package:example/home/domain/use-cases/cache_add_comment5_use_case.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/data/models/device_settings_model.dart';

import 'cache_add_comment5_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<HomeRepository>(),
])
void main() {
late CacheAddComment5UseCase cacheAddComment5UseCase;
late HomeRepository repository;
late DeviceSettingsModel data;
late Failure failure;
setUp(() {
repository = MockHomeRepository();
cacheAddComment5UseCase = CacheAddComment5UseCase(repository);
failure = Failure(1, 'message');
data = DeviceSettingsModel.fromJson(json('expected_device_settings_model'));
});

webService() => repository.cacheAddComment5(data: data);

group('CacheAddComment5UseCase ', () {
test('cacheAddComment5 FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await cacheAddComment5UseCase.execute(request: data);
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('cacheAddComment5 SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => const Right(unit));
final res = await cacheAddComment5UseCase.execute(request: data);
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
