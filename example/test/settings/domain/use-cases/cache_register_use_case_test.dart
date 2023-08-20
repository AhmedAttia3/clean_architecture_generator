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
import 'package:example/settings/domain/use-cases/cache_register_use_case.dart';
import 'package:example/settings/domain/repository/settings_repository.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/address_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/core/base_response.dart';

import 'cache_register_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRepository>(),
])
void main() {
late CacheRegisterUseCase cacheRegisterUseCase;
late SettingsRepository repository;
late UserModel data;
late Failure failure;
setUp(() {
repository = MockSettingsRepository();
cacheRegisterUseCase = CacheRegisterUseCase(repository);
failure = Failure(1, 'message');
data = UserModel.fromJson(json('expected_user_model'));
});

webService() => repository.cacheRegister(data: data);

group('CacheRegisterUseCase ', () {
test('cacheRegister FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await cacheRegisterUseCase.execute(request: data);
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('cacheRegister SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => const Right(unit));
final res = await cacheRegisterUseCase.execute(request: data);
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
