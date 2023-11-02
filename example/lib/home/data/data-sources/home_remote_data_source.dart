import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:mwidgets/mwidgets.dart';

///[Implementation]
abstract class HomeRemoteDataSource {
  Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> addComment({
    required String storyId,
    required String content,
  });

  Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> addComment2({
    required String storyId,
    required String content,
  });

  Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> addComment3({
    required String storyId,
    required String content,
  });

  Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> addComment4({
    required String storyId,
    required String content,
  });

  Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> addComment5({
    required String storyId,
    required String content,
  });

  Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> addComment6({
    required String storyId,
    required String content,
  });

  Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> addComment7({
    required String storyId,
    required String content,
  });
}
