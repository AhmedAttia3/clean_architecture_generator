import 'package:dio/dio.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:retrofit/retrofit.dart';

part 'home_client_services.g.dart';

@RestApi()
abstract class HomeClientServices {
  factory HomeClientServices(Dio dio, {String baseUrl}) = _HomeClientServices;

  @POST('sendCode')
  Future<BaseResponse<DeviceSettingsModel?>> addComment({
    @Field('story_id') required String storyId,
    @Field('content') required String content,
  });

  @POST('sendCode')
  Future<BaseResponse<DeviceSettingsModel?>> addComment2({
    @Field('story_id') required String storyId,
    @Field('content') required String content,
  });

  @POST('sendCode')
  Future<BaseResponse<DeviceSettingsModel?>> addComment3({
    @Field('story_id') required String storyId,
    @Field('content') required String content,
  });

  @POST('sendCode')
  Future<BaseResponse<DeviceSettingsModel?>> addComment4({
    @Field('story_id') required String storyId,
    @Field('content') required String content,
  });

  @POST('sendCode')
  Future<BaseResponse<DeviceSettingsModel?>> addComment5({
    @Field('story_id') required String storyId,
    @Field('content') required String content,
  });

  @POST('sendCode')
  Future<BaseResponse<DeviceSettingsModel?>> addComment6({
    @Field('story_id') required String storyId,
    @Field('content') required String content,
  });

  @POST('sendCode')
  Future<BaseResponse<DeviceSettingsModel?>> addComment7({
    @Field('story_id') required String storyId,
    @Field('content') required String content,
  });
}
