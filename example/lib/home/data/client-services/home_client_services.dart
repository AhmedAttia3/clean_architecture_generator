import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/core/base/base_response.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:retrofit/retrofit.dart';
part 'home_client_services.g.dart';

 @RestApi()
 abstract class HomeClientServices {
 factory HomeClientServices(Dio dio, {String baseUrl}) =
 _HomeClientServices;
     @POST('sendCode')
     Future<BaseResponse<DeviceSettingsModel?>> addComment({
         @Field('story_id') required String  storyId1,
         @Field('content1') required String  content1,
     });







































  @POST('sendCode')
  Future<BaseResponse<DeviceSettingsModel?>> addComment2({
    @Field('story_id') required String storyId2,
    @Field('content2') required String content2,
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
         @Field('story_id') required String  storyId1,
         @Field('content1') required String  content1,
     });

     @POST('sendCode')
     Future<BaseResponse<DeviceSettingsModel?>> addComment7({
         @Field('story_id') required String  storyId2,
         @Field('content2') required String  content2,
     });

     @POST('sendCode')
     Future<BaseResponse<DeviceSettingsModel?>> addComment8({
         @Field('story_id') required String  storyId3,
         @Field('content3') required String  content3,
     });






































}
