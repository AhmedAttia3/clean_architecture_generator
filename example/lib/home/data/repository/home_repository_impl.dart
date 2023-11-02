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
    required String storyId,
    required String content,
  }) async {
    return await homeRemoteDataSource.addComment(
      storyId: storyId,
      content: content,
    );
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment2({
    required String storyId,
    required String content,
  }) async {
    return await homeRemoteDataSource.addComment2(
      storyId: storyId,
      content: content,
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
    required String storyId,
    required String content,
  }) async {
    final res = await homeRemoteDataSource.addComment6(
      storyId: storyId,
      content: content,
    );
    await res.right((data) async {
      if (data.success) {
        homeLocalDataSource.cacheAddComment6(data: data.data!);
      }
    });
    return res;
  }

  @override
  Future<Either<Failure, Unit>> cacheAddComment6({
    required DeviceSettingsModel data,
  }) async {
    return await homeLocalDataSource.cacheAddComment6(data: data);
  }

  @override
  Either<Failure, DeviceSettingsEntity> getCacheAddComment6() {
    return homeLocalDataSource.getCacheAddComment6();
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment7({
    required String storyId,
    required String content,
  }) async {
    final res = await homeRemoteDataSource.addComment7(
      storyId: storyId,
      content: content,
    );
    await res.right((data) async {
      if (data.success) {
        homeLocalDataSource.cacheAddComment7(data: data.data!);
      }
    });
    return res;
  }

  @override
  Future<Either<Failure, Unit>> cacheAddComment7({
    required DeviceSettingsModel data,
  }) async {
    return await homeLocalDataSource.cacheAddComment7(data: data);
  }

  @override
  Either<Failure, DeviceSettingsEntity> getCacheAddComment7() {
    return homeLocalDataSource.getCacheAddComment7();
  }
}
