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
import 'package:example/home/data/data-sources/home_local_data_source.dart';
import 'package:example/home/data/data-sources/home_remote_data_source.dart';
import 'package:example/home/data/repository/home_repository_impl.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/home/domain/requests/add_comment_request.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/requests/add_comment2_request.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/requests/add_comment3_request.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/requests/add_comment4_request.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/requests/add_comment5_request.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/requests/add_comment6_request.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/requests/add_comment7_request.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/requests/add_comment8_request.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:mwidgets/mwidgets.dart';
import 'home_repository_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<HomeRemoteDataSource>(),
MockSpec<HomeLocalDataSource>(),
])
void main() {
late HomeRemoteDataSource dataSource;
late HomeRepository repository;
late Failure failure;
late HomeLocalDataSource homeLocalDataSource;
late BaseResponse<DeviceSettingsModel?> addCommentResponse;
late AddCommentRequest addCommentRequest;
late BaseResponse<DeviceSettingsModel?> addComment2Response;
late AddComment2Request addComment2Request;
late BaseResponse<DeviceSettingsModel?> addComment3Response;
late AddComment3Request addComment3Request;
late BaseResponse<DeviceSettingsModel?> addComment4Response;
late AddComment4Request addComment4Request;
late BaseResponse<DeviceSettingsModel?> addComment5Response;
late AddComment5Request addComment5Request;
late DeviceSettingsModel deviceSettingsModels;
late BaseResponse<DeviceSettingsModel?> addComment6Response;
late AddComment6Request addComment6Request;
late BaseResponse<DeviceSettingsModel?> addComment7Response;
late AddComment7Request addComment7Request;
late BaseResponse<DeviceSettingsModel?> addComment8Response;
late AddComment8Request addComment8Request;
setUp(() {
failure = Failure(999,"Cache failure");
homeLocalDataSource = MockHomeLocalDataSource();
dataSource = MockHomeRemoteDataSource();
repository = HomeRepositoryImplement(
dataSource,
homeLocalDataSource,
);
///[AddComment]
addCommentResponse = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
///[AddComment2]
addComment2Response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
///[AddComment3]
addComment3Response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
///[AddComment4]
addComment4Response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
///[AddComment5]
addComment5Response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
deviceSettingsModels = DeviceSettingsModel.fromJson(json('expected_device_settings_model'));
///[AddComment6]
addComment6Response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
///[AddComment7]
addComment7Response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
///[AddComment8]
addComment8Response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
});
addComment() => dataSource.addComment(storyId1: "storyId1",content1: "content1",);
addComment2() => dataSource.addComment2(storyId2: "storyId2",content2: "content2",);
addComment3() => dataSource.addComment3(storyId: "storyId",content: "content",);
addComment4() => dataSource.addComment4(storyId: "storyId",content: "content",);
addComment5() => dataSource.addComment5(storyId: "storyId",content: "content",);
cacheAddComment5() => homeLocalDataSource.cacheAddComment5(data : deviceSettingsModels);

getCacheAddComment5() => homeLocalDataSource.getCacheAddComment5();

addComment6() => dataSource.addComment6(storyId1: "storyId1",content1: "content1",);
addComment7() => dataSource.addComment7(storyId2: "storyId2",content2: "content2",);
addComment8() => dataSource.addComment8(storyId3: "storyId3",content3: "content3",);
group('HomeRepository Repository', () {
///[addComment Success Test]
test('addComment Success', () async {
when(addComment())
.thenAnswer((realInvocation) async => Right(addCommentResponse));
final res = await repository.addComment(storyId1: "storyId1",content1: "content1",);
expect(res.rightOrNull(), addCommentResponse);
verify(addComment());
verifyNoMoreInteractions(dataSource);
});

///[addComment Failure Test]
test('addComment Failure', () async {
when(addComment())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.addComment(storyId1: "storyId1",content1: "content1",);
expect(res.leftOrNull(), isA<Failure>());
verify(addComment());
verifyNoMoreInteractions(dataSource);
});

///[addComment2 Success Test]
test('addComment2 Success', () async {
when(addComment2())
.thenAnswer((realInvocation) async => Right(addComment2Response));
final res = await repository.addComment2(storyId2: "storyId2",content2: "content2",);
expect(res.rightOrNull(), addComment2Response);
verify(addComment2());
verifyNoMoreInteractions(dataSource);
});

///[addComment2 Failure Test]
test('addComment2 Failure', () async {
when(addComment2())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.addComment2(storyId2: "storyId2",content2: "content2",);
expect(res.leftOrNull(), isA<Failure>());
verify(addComment2());
verifyNoMoreInteractions(dataSource);
});

///[addComment3 Success Test]
test('addComment3 Success', () async {
when(addComment3())
.thenAnswer((realInvocation) async => Right(addComment3Response));
final res = await repository.addComment3(storyId: "storyId",content: "content",);
expect(res.rightOrNull(), addComment3Response);
verify(addComment3());
verifyNoMoreInteractions(dataSource);
});

///[addComment3 Failure Test]
test('addComment3 Failure', () async {
when(addComment3())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.addComment3(storyId: "storyId",content: "content",);
expect(res.leftOrNull(), isA<Failure>());
verify(addComment3());
verifyNoMoreInteractions(dataSource);
});

///[addComment4 Success Test]
test('addComment4 Success', () async {
when(addComment4())
.thenAnswer((realInvocation) async => Right(addComment4Response));
final res = await repository.addComment4(storyId: "storyId",content: "content",);
expect(res.rightOrNull(), addComment4Response);
verify(addComment4());
verifyNoMoreInteractions(dataSource);
});

///[addComment4 Failure Test]
test('addComment4 Failure', () async {
when(addComment4())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.addComment4(storyId: "storyId",content: "content",);
expect(res.leftOrNull(), isA<Failure>());
verify(addComment4());
verifyNoMoreInteractions(dataSource);
});

///[addComment5 Success Test]
test('addComment5 Success', () async {
when(addComment5())
.thenAnswer((realInvocation) async => Right(addComment5Response));
final res = await repository.addComment5(storyId: "storyId",content: "content",);
expect(res.rightOrNull(), addComment5Response);
verify(addComment5());
verifyNoMoreInteractions(dataSource);
});

///[addComment5 Failure Test]
test('addComment5 Failure', () async {
when(addComment5())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.addComment5(storyId: "storyId",content: "content",);
expect(res.leftOrNull(), isA<Failure>());
verify(addComment5());
verifyNoMoreInteractions(dataSource);
});

///[cacheAddComment5 Success]
test('cacheAddComment5', () async {
when(cacheAddComment5()).thenAnswer((realInvocation) async => const Right(unit));
final res = await repository.cacheAddComment5(data:deviceSettingsModels);
expect(res.rightOrNull(), unit);
verify(cacheAddComment5());
verifyNoMoreInteractions(homeLocalDataSource);
});

///[cacheAddComment5 Failure]
test('cacheAddComment5', () async {
when(cacheAddComment5()).thenAnswer((realInvocation) async => Left(failure));
final res = await repository.cacheAddComment5(data:deviceSettingsModels);
expect(res.leftOrNull(), isA<Failure>());
verify(cacheAddComment5());
verifyNoMoreInteractions(homeLocalDataSource);
});

///[getCacheAddComment5 Success]
test('getCacheAddComment5', () async {
when(getCacheAddComment5()).thenAnswer((realInvocation) => Right(deviceSettingsModels));

final res = repository.getCacheAddComment5();
expect(res.rightOrNull(),isA<DeviceSettingsModel>());
verify(getCacheAddComment5());
verifyNoMoreInteractions(homeLocalDataSource);
});

///[getCacheAddComment5 Failure]
test('getCacheAddComment5', () async {
when(getCacheAddComment5()).thenAnswer((realInvocation) => Left(failure));

final res = repository.getCacheAddComment5();
expect(res.leftOrNull(),isA<Failure>());
verify(getCacheAddComment5());
verifyNoMoreInteractions(homeLocalDataSource);
});

///[addComment6 Success Test]
test('addComment6 Success', () async {
when(addComment6())
.thenAnswer((realInvocation) async => Right(addComment6Response));
final res = await repository.addComment6(storyId1: "storyId1",content1: "content1",);
expect(res.rightOrNull(), addComment6Response);
verify(addComment6());
verifyNoMoreInteractions(dataSource);
});

///[addComment6 Failure Test]
test('addComment6 Failure', () async {
when(addComment6())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.addComment6(storyId1: "storyId1",content1: "content1",);
expect(res.leftOrNull(), isA<Failure>());
verify(addComment6());
verifyNoMoreInteractions(dataSource);
});

///[addComment7 Success Test]
test('addComment7 Success', () async {
when(addComment7())
.thenAnswer((realInvocation) async => Right(addComment7Response));
final res = await repository.addComment7(storyId2: "storyId2",content2: "content2",);
expect(res.rightOrNull(), addComment7Response);
verify(addComment7());
verifyNoMoreInteractions(dataSource);
});

///[addComment7 Failure Test]
test('addComment7 Failure', () async {
when(addComment7())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.addComment7(storyId2: "storyId2",content2: "content2",);
expect(res.leftOrNull(), isA<Failure>());
verify(addComment7());
verifyNoMoreInteractions(dataSource);
});

///[addComment8 Success Test]
test('addComment8 Success', () async {
when(addComment8())
.thenAnswer((realInvocation) async => Right(addComment8Response));
final res = await repository.addComment8(storyId3: "storyId3",content3: "content3",);
expect(res.rightOrNull(), addComment8Response);
verify(addComment8());
verifyNoMoreInteractions(dataSource);
});

///[addComment8 Failure Test]
test('addComment8 Failure', () async {
when(addComment8())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.addComment8(storyId3: "storyId3",content3: "content3",);
expect(res.leftOrNull(), isA<Failure>());
verify(addComment8());
verifyNoMoreInteractions(dataSource);
});

});
}

///[FromJson]
Map<String, dynamic> json(String path) {
 return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
