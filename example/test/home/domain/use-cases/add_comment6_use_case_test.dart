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
import 'package:example/home/domain/use-cases/add_comment6_use_case.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/requests/add_comment_request.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/requests/add_comment2_request.dart';
import 'package:example/home/domain/requests/add_comment3_request.dart';
import 'package:example/home/domain/requests/add_comment4_request.dart';
import 'package:example/home/domain/requests/add_comment5_request.dart';
import 'package:example/home/domain/requests/add_comment6_request.dart';
import 'package:example/home/domain/requests/add_comment7_request.dart';
import 'package:example/home/domain/requests/add_comment8_request.dart';

import 'add_comment6_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<HomeRepository>(),
])
void main() {
late AddComment6UseCase addComment6UseCase;
late HomeRepository repository;
late BaseResponse<DeviceSettingsModel?> success;
late Failure failure;
late AddComment6Request addComment6Request;
setUp(() {
repository = MockHomeRepository();
addComment6UseCase = AddComment6UseCase(repository);
failure = Failure(1, 'message');
success = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
});

addComment6Request = AddComment6Request(storyId1: "storyId1",content1: "content1",);

webService() => repository.addComment6(storyId1: "storyId1",content1: "content1",);

group('AddComment6UseCase ', () {
test('addComment6 FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await addComment6UseCase.execute(
request: addComment6Request);
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('addComment6 SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => Right(success));
final res = await addComment6UseCase.execute(
request: addComment6Request);
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
