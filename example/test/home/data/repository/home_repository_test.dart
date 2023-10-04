import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/data/data-sources/home_remote_data_source.dart';
import 'package:example/home/data/repository/home_repository_impl.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/home/data/models/governorate_model.dart';
import 'package:example/home/domain/requests/get_result_request.dart';
import 'package:example/home/data/models/result_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:mwidgets/mwidgets.dart';
import 'home_repository_test.mocks.dart';
@GenerateNiceMocks([
MockSpec<HomeRemoteDataSource>(),
])
void main() {
late HomeRemoteDataSource dataSource;
late HomeRepository repository;
late Failure failure;
late BaseResponse<List<GovernorateModel>?> getGovernoratesResponse;
late BaseResponse<ResultModel?> getResultResponse;
late GetResultRequest getResultRequest;
late BaseResponse<int> addFavoriteResponse;
late BaseResponse<DeviceSettingsModel?> updateUserResponse;
setUp(() {
failure = Failure(999,"Cache failure");
dataSource = MockHomeRemoteDataSource();
repository = HomeRepositoryImplement(
dataSource,
);
///[GetGovernorates]
getGovernoratesResponse = BaseResponse<List<GovernorateModel>?>(
message: 'message',
success: true,
data: List.generate(
2,
(index) =>
GovernorateModel.fromJson(json('expected_governorate_model')),
));
///[GetResult]
getResultResponse = BaseResponse<ResultModel?>(
message: 'message',
success: true,
data: ResultModel.fromJson(json('expected_result_model')),);
///[AddFavorite]
addFavoriteResponse = BaseResponse<int>(
message: 'message',
success: true,
data: 0,);
///[UpdateUser]
updateUserResponse = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
});
getGovernorates() => dataSource.getGovernorates();
getResult() => dataSource.getResult(countryId: 0,termId: 0,studentName: "studentName",sittingNumber: "sittingNumber",);
addFavorite() => dataSource.addFavorite(countryId: 0,);
updateUser() => dataSource.updateUser(firebaseToken: 0,);
group('HomeRepository Repository', () {
///[getGovernorates Success Test]
test('getGovernorates Success', () async {
when(getGovernorates())
.thenAnswer((realInvocation) async => Right(getGovernoratesResponse));
final res = await repository.getGovernorates();
expect(res.rightOrNull(), getGovernoratesResponse);
verify(getGovernorates());
verifyNoMoreInteractions(dataSource);
});

///[getGovernorates Failure Test]
test('getGovernorates Failure', () async {
when(getGovernorates())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.getGovernorates();
expect(res.leftOrNull(), isA<Failure>());
verify(getGovernorates());
verifyNoMoreInteractions(dataSource);
});

///[getResult Success Test]
test('getResult Success', () async {
when(getResult())
.thenAnswer((realInvocation) async => Right(getResultResponse));
final res = await repository.getResult(countryId: 0,termId: 0,studentName: "studentName",sittingNumber: "sittingNumber",);
expect(res.rightOrNull(), getResultResponse);
verify(getResult());
verifyNoMoreInteractions(dataSource);
});

///[getResult Failure Test]
test('getResult Failure', () async {
when(getResult())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.getResult(countryId: 0,termId: 0,studentName: "studentName",sittingNumber: "sittingNumber",);
expect(res.leftOrNull(), isA<Failure>());
verify(getResult());
verifyNoMoreInteractions(dataSource);
});

///[addFavorite Success Test]
test('addFavorite Success', () async {
when(addFavorite())
.thenAnswer((realInvocation) async => Right(addFavoriteResponse));
final res = await repository.addFavorite(countryId: 0,);
expect(res.rightOrNull(), addFavoriteResponse);
verify(addFavorite());
verifyNoMoreInteractions(dataSource);
});

///[addFavorite Failure Test]
test('addFavorite Failure', () async {
when(addFavorite())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.addFavorite(countryId: 0,);
expect(res.leftOrNull(), isA<Failure>());
verify(addFavorite());
verifyNoMoreInteractions(dataSource);
});

///[updateUser Success Test]
test('updateUser Success', () async {
when(updateUser())
.thenAnswer((realInvocation) async => Right(updateUserResponse));
final res = await repository.updateUser(firebaseToken: 0,);
expect(res.rightOrNull(), updateUserResponse);
verify(updateUser());
verifyNoMoreInteractions(dataSource);
});

///[updateUser Failure Test]
test('updateUser Failure', () async {
when(updateUser())
.thenAnswer((realInvocation) async => Left(failure));
final res = await repository.updateUser(firebaseToken: 0,);
expect(res.leftOrNull(), isA<Failure>());
verify(updateUser());
verifyNoMoreInteractions(dataSource);
});

});
}

///[FromJson]
Map<String, dynamic> json(String path) {
 return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
