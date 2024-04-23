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
import 'package:example/home/data/client-services/home_client_services.dart';
import 'package:example/home/data/data-sources/home_remote_data_source.dart';
import 'package:example/home/data/data-sources/home_remote_data_source_impl.dart';
import 'package:example/core/base/safe_request_handler.dart';
import 'package:example/core/base/network.dart';
import 'package:example/home/domain/requests/add_comment_request.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/requests/add_comment2_request.dart';
import 'package:example/home/domain/requests/add_comment3_request.dart';
import 'package:example/home/domain/requests/add_comment4_request.dart';
import 'package:example/home/domain/requests/add_comment5_request.dart';
import 'package:example/home/domain/requests/add_comment6_request.dart';
import 'package:example/home/domain/requests/add_comment7_request.dart';
import 'package:example/home/domain/requests/add_comment8_request.dart';

import 'home_remote_data_source_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<HomeClientServices>(),
MockSpec<NetworkInfo>(),
])
void main() {
late HomeClientServices dataSource;
late HomeRemoteDataSource remoteDataSource;
late Failure failure;
late SafeApi apiCall;
late NetworkInfo networkInfo;
late BaseResponse<DeviceSettingsModel?> addCommentResponse;
late BaseResponse<DeviceSettingsModel?> addComment2Response;
late BaseResponse<DeviceSettingsModel?> addComment3Response;
late BaseResponse<DeviceSettingsModel?> addComment4Response;
late BaseResponse<DeviceSettingsModel?> addComment5Response;
late BaseResponse<DeviceSettingsModel?> addComment6Response;
late BaseResponse<DeviceSettingsModel?> addComment7Response;
late BaseResponse<DeviceSettingsModel?> addComment8Response;
setUp(() {
failure = Failure(999,"Cache failure");
networkInfo = MockNetworkInfo();
apiCall = SafeApi(networkInfo);
dataSource = MockHomeClientServices();
remoteDataSource = HomeRemoteDataSourceImplement(
dataSource,
apiCall,
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
addComment6() => dataSource.addComment6(storyId1: "storyId1",content1: "content1",);
addComment7() => dataSource.addComment7(storyId2: "storyId2",content2: "content2",);
addComment8() => dataSource.addComment8(storyId3: "storyId3",content3: "content3",);
group('HomeRemoteDataSource RemoteDataSource', () {
///[No Internet Test]
test('No Internet', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
final res = await remoteDataSource.addComment(storyId1: "storyId1",content1: "content1",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verifyNoMoreInteractions(networkInfo);
});

///[addComment Success Test]
test('addComment Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(addComment())
.thenAnswer((realInvocation) async => addCommentResponse);
final res = await remoteDataSource.addComment(storyId1: "storyId1",content1: "content1",);
expect(res.rightOrNull(), addCommentResponse);
verify(networkInfo.isConnected);
verify(addComment());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment Failure Test]
test('addComment Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(addComment())
.thenAnswer((realInvocation) async => addCommentResponse);
final res = await remoteDataSource.addComment(storyId1: "storyId1",content1: "content1",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(addComment());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment2 Success Test]
test('addComment2 Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(addComment2())
.thenAnswer((realInvocation) async => addComment2Response);
final res = await remoteDataSource.addComment2(storyId2: "storyId2",content2: "content2",);
expect(res.rightOrNull(), addComment2Response);
verify(networkInfo.isConnected);
verify(addComment2());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment2 Failure Test]
test('addComment2 Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(addComment2())
.thenAnswer((realInvocation) async => addComment2Response);
final res = await remoteDataSource.addComment2(storyId2: "storyId2",content2: "content2",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(addComment2());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment3 Success Test]
test('addComment3 Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(addComment3())
.thenAnswer((realInvocation) async => addComment3Response);
final res = await remoteDataSource.addComment3(storyId: "storyId",content: "content",);
expect(res.rightOrNull(), addComment3Response);
verify(networkInfo.isConnected);
verify(addComment3());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment3 Failure Test]
test('addComment3 Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(addComment3())
.thenAnswer((realInvocation) async => addComment3Response);
final res = await remoteDataSource.addComment3(storyId: "storyId",content: "content",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(addComment3());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment4 Success Test]
test('addComment4 Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(addComment4())
.thenAnswer((realInvocation) async => addComment4Response);
final res = await remoteDataSource.addComment4(storyId: "storyId",content: "content",);
expect(res.rightOrNull(), addComment4Response);
verify(networkInfo.isConnected);
verify(addComment4());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment4 Failure Test]
test('addComment4 Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(addComment4())
.thenAnswer((realInvocation) async => addComment4Response);
final res = await remoteDataSource.addComment4(storyId: "storyId",content: "content",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(addComment4());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment5 Success Test]
test('addComment5 Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(addComment5())
.thenAnswer((realInvocation) async => addComment5Response);
final res = await remoteDataSource.addComment5(storyId: "storyId",content: "content",);
expect(res.rightOrNull(), addComment5Response);
verify(networkInfo.isConnected);
verify(addComment5());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment5 Failure Test]
test('addComment5 Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(addComment5())
.thenAnswer((realInvocation) async => addComment5Response);
final res = await remoteDataSource.addComment5(storyId: "storyId",content: "content",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(addComment5());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment6 Success Test]
test('addComment6 Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(addComment6())
.thenAnswer((realInvocation) async => addComment6Response);
final res = await remoteDataSource.addComment6(storyId1: "storyId1",content1: "content1",);
expect(res.rightOrNull(), addComment6Response);
verify(networkInfo.isConnected);
verify(addComment6());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment6 Failure Test]
test('addComment6 Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(addComment6())
.thenAnswer((realInvocation) async => addComment6Response);
final res = await remoteDataSource.addComment6(storyId1: "storyId1",content1: "content1",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(addComment6());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment7 Success Test]
test('addComment7 Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(addComment7())
.thenAnswer((realInvocation) async => addComment7Response);
final res = await remoteDataSource.addComment7(storyId2: "storyId2",content2: "content2",);
expect(res.rightOrNull(), addComment7Response);
verify(networkInfo.isConnected);
verify(addComment7());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment7 Failure Test]
test('addComment7 Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(addComment7())
.thenAnswer((realInvocation) async => addComment7Response);
final res = await remoteDataSource.addComment7(storyId2: "storyId2",content2: "content2",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(addComment7());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment8 Success Test]
test('addComment8 Success', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
when(addComment8())
.thenAnswer((realInvocation) async => addComment8Response);
final res = await remoteDataSource.addComment8(storyId3: "storyId3",content3: "content3",);
expect(res.rightOrNull(), addComment8Response);
verify(networkInfo.isConnected);
verify(addComment8());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

///[addComment8 Failure Test]
test('addComment8 Failure', () async {
when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
when(addComment8())
.thenAnswer((realInvocation) async => addComment8Response);
final res = await remoteDataSource.addComment8(storyId3: "storyId3",content3: "content3",);
expect(res.leftOrNull(), isA<Failure>());
verify(networkInfo.isConnected);
verify(addComment8());
verifyNoMoreInteractions(networkInfo);
verifyNoMoreInteractions(dataSource);
});

});
}

///[FromJson]
Map<String, dynamic> json(String path) {
 return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
