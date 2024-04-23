import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/home/data/data-sources/home_local_data_source.dart';
import 'package:example/home/data/data-sources/home_remote_data_source.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';

///[HomeRepositoryImplement]
///[Implementation]
@Injectable(as: HomeRepository)
class HomeRepositoryImplement implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  const HomeRepositoryImplement(
    this.homeRemoteDataSource,
    this.homeLocalDataSource,
  );

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment({
    required String storyId1,
    required String content1,
  }) async {
    return await homeRemoteDataSource.addComment(
      storyId1: storyId1,
      content1: content1,
    );
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment2({
    required String storyId2,
    required String content2,
  }) async {
    return await homeRemoteDataSource.addComment2(
      storyId2: storyId2,
      content2: content2,
    );
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment3({
    required String storyId,
    required String content,
  }) async {
    return await homeRemoteDataSource.addComment3(
      storyId: storyId,
      content: content,
    );
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment4({
    required String storyId,
    required String content,
  }) async {
    return await homeRemoteDataSource.addComment4(
      storyId: storyId,
      content: content,
    );
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment5({
    required String storyId,
    required String content,
  }) async {
    final res = await homeRemoteDataSource.addComment5(
      storyId: storyId,
      content: content,
    );
    await res.right((data) async {
      if (data.success) {
        homeLocalDataSource.cacheAddComment5(data: data.data!);
      }
    });
    return res;
  }

  @override
  Future<Either<Failure, Unit>> cacheAddComment5({
    required DeviceSettingsModel data,
  }) async {
    return await homeLocalDataSource.cacheAddComment5(data: data);
  }

  @override
  Either<Failure, DeviceSettingsEntity> getCacheAddComment5() {
    return homeLocalDataSource.getCacheAddComment5();
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment6({
    required String storyId1,
    required String content1,
  }) async {
    return await homeRemoteDataSource.addComment6(
      storyId1: storyId1,
      content1: content1,
    );
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment7({
    required String storyId2,
    required String content2,
  }) async {
    return await homeRemoteDataSource.addComment7(
      storyId2: storyId2,
      content2: content2,
    );
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment8({
    required String storyId3,
    required String content3,
  }) async {
    return await homeRemoteDataSource.addComment8(
      storyId3: storyId3,
      content3: content3,
    );
  }
}
