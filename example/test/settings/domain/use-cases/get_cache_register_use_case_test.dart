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
import 'package:example/settings/domain/use-cases/get_cache_register_use_case.dart';
import 'package:example/settings/domain/repository/settings_repository.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/address_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/core/base_response.dart';

import 'get_cache_register_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<SettingsRepository>(),
])
void main() {
late GetCacheRegisterUseCase getCacheRegisterUseCase;
late SettingsRepository repository;
late UserModel success;
late Failure failure;
setUp(() {
repository = MockSettingsRepository();
getCacheRegisterUseCase = GetCacheRegisterUseCase(repository);
failure = Failure(1, 'message');
success = UserModel.fromJson(json('expected_user_model'));
});

webService() => repository.getCacheRegister();

group('GetCacheRegisterUseCase ', () {
test('getCacheRegister FAILURE', ()  {
when(webService()).thenAnswer((realInvocation) => Left(failure));
final res = getCacheRegisterUseCase.execute();
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('getCacheRegister SUCCESS', () {
when(webService()).thenAnswer((realInvocation) => Right(success));
final res = getCacheRegisterUseCase.execute();
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
