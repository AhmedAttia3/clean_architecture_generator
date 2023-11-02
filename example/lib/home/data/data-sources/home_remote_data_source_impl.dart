import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/safe_request_handler.dart';
import 'package:example/home/data/client-services/home_client_services.dart';
import 'package:example/home/data/data-sources/home_remote_data_source.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';

///[HomeRemoteDataSource]
///[Implementation]
@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImplement implements HomeRemoteDataSource {
  final HomeClientServices homeClientServices;
  final SafeApi api;

  const HomeRemoteDataSourceImplement(
    this.homeClientServices,
    this.api,
  );

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> addComment({
    required String storyId,
    required String content,
  }) async {
    return await api<BaseResponse<DeviceSettingsModel?>>(
      apiCall: homeClientServices.addComment(
        storyId: storyId,
        content: content,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> addComment2({
    required String storyId,
    required String content,
  }) async {
    return await api<BaseResponse<DeviceSettingsModel?>>(
      apiCall: homeClientServices.addComment2(
        storyId: storyId,
        content: content,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> addComment3({
    required String storyId,
    required String content,
  }) async {
    return await api<BaseResponse<DeviceSettingsModel?>>(
      apiCall: homeClientServices.addComment3(
        storyId: storyId,
        content: content,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> addComment4({
    required String storyId,
    required String content,
  }) async {
    return await api<BaseResponse<DeviceSettingsModel?>>(
      apiCall: homeClientServices.addComment4(
        storyId: storyId,
        content: content,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> addComment5({
    required String storyId,
    required String content,
  }) async {
    return await api<BaseResponse<DeviceSettingsModel?>>(
      apiCall: homeClientServices.addComment5(
        storyId: storyId,
        content: content,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> addComment6({
    required String storyId,
    required String content,
  }) async {
    return await api<BaseResponse<DeviceSettingsModel?>>(
      apiCall: homeClientServices.addComment6(
        storyId: storyId,
        content: content,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> addComment7({
    required String storyId,
    required String content,
  }) async {
    return await api<BaseResponse<DeviceSettingsModel?>>(
      apiCall: homeClientServices.addComment7(
        storyId: storyId,
        content: content,
      ),
    );
  }
}
