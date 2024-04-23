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
import 'package:example/home/domain/use-cases/add_comment2_use_case.dart';
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

import 'add_comment2_use_case_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<HomeRepository>(),
])
void main() {
late AddComment2UseCase addComment2UseCase;
late HomeRepository repository;
late BaseResponse<DeviceSettingsModel?> success;
late Failure failure;
late AddComment2Request addComment2Request;
setUp(() {
repository = MockHomeRepository();
addComment2UseCase = AddComment2UseCase(repository);
failure = Failure(1, 'message');
success = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
});

addComment2Request = AddComment2Request(storyId2: "storyId2",content2: "content2",);

webService() => repository.addComment2(storyId2: "storyId2",content2: "content2",);

group('AddComment2UseCase ', () {
test('addComment2 FAILURE', () async {
when(webService()).thenAnswer((realInvocation) async => Left(failure));
final res = await addComment2UseCase.execute(
request: addComment2Request);
expect(res.left((data) {}), failure);
verify(webService());
verifyNoMoreInteractions(repository);
});


test('addComment2 SUCCESS', () async {
when(webService()).thenAnswer((realInvocation) async => Right(success));
final res = await addComment2UseCase.execute(
request: addComment2Request);
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
