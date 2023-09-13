import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/domain/use-cases/get_governorates_use_case.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/data/models/governorate_model.dart';
import 'package:example/home/domain/requests/get_result_request.dart';
import 'package:example/home/data/models/result_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/core/base/base_response.dart';

import 'get_governorates_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<HomeRepository>(),
])
void main() {
late GetGovernoratesUseCase getGovernoratesUseCase;
late HomeRepository repository;
late BaseResponse<List<GovernorateModel>?> success;
late Failure failure;
setUp(() {
repository = MockHomeRepository();
getGovernoratesUseCase = GetGovernoratesUseCase(repository);
failure = Failure(1, 'message');
success = BaseResponse<List<GovernorateModel>?>(
message: 'message',
success: true,
data: List.generate(
2,
(index) =>
GovernorateModel.fromJson(json('expected_governorate_model')),
));
});

webService() => repository.getGovernorates();

group('GetGovernoratesUseCase ', () {
test('getGovernorates FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await getGovernoratesUseCase.execute(
);
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('getGovernorates SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => Right(success));
final res = await getGovernoratesUseCase.execute(
);
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
