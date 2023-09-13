import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/domain/use-cases/get_result_use_case.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/data/models/governorate_model.dart';
import 'package:example/home/domain/requests/get_result_request.dart';
import 'package:example/home/data/models/result_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/core/base/base_response.dart';

import 'get_result_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<HomeRepository>(),
])
void main() {
late GetResultUseCase getResultUseCase;
late HomeRepository repository;
late BaseResponse<ResultModel?> success;
late Failure failure;
late GetResultRequest getResultRequest;
setUp(() {
repository = MockHomeRepository();
getResultUseCase = GetResultUseCase(repository);
failure = Failure(1, 'message');
success = BaseResponse<ResultModel?>(
message: 'message',
success: true,
data: ResultModel.fromJson(json('expected_result_model')),);
});

getResultRequest = GetResultRequest(countryId: 0,termId: 0,studentName: "studentName",sittingNumber: "sittingNumber",);

webService() => repository.getResult(countryId: 0,termId: 0,studentName: "studentName",sittingNumber: "sittingNumber",);

group('GetResultUseCase ', () {
test('getResult FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await getResultUseCase.execute(
request: getResultRequest);
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('getResult SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => Right(success));
final res = await getResultUseCase.execute(
request: getResultRequest);
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
