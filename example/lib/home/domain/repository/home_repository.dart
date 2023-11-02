import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:mwidgets/mwidgets.dart';

///[Implementation]
abstract class HomeRepository {
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment({
    required String storyId,
    required String content,
  });

  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment2({
    required String storyId,
    required String content,
  });

  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment3({
    required String storyId,
    required String content,
  });

  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment4({
    required String storyId,
    required String content,
  });

  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment5({
    required String storyId,
    required String content,
  });

  Future<Either<Failure, Unit>> cacheAddComment5({
    required DeviceSettingsModel data,
  });

  Either<Failure, DeviceSettingsEntity> getCacheAddComment5();

  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment6({
    required String storyId,
    required String content,
  });

  Future<Either<Failure, Unit>> cacheAddComment6({
    required DeviceSettingsModel data,
  });

  Either<Failure, DeviceSettingsEntity> getCacheAddComment6();

  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> addComment7({
    required String storyId,
    required String content,
  });

  Future<Either<Failure, Unit>> cacheAddComment7({
    required DeviceSettingsModel data,
  });

  Either<Failure, DeviceSettingsEntity> getCacheAddComment7();
}
