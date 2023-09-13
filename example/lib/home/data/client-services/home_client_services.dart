import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/data/models/governorate_model.dart';
import 'package:example/home/data/models/result_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/core/base/base_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'home_client_services.g.dart';

 @RestApi()
 abstract class HomeClientServices {
 factory HomeClientServices(Dio dio, {String baseUrl}) =
 _HomeClientServices;
     @GET('/api/governates')
     Future<BaseResponse<List<GovernorateModel>?>> getGovernorates();

     @GET('/api/result/{countryId}/{termId}')
     Future<BaseResponse<ResultModel?>> getResult({
         @Path('countryId') required int  countryId,
         @Path('termId') int?  termId,
         @Query('student_name') String?  studentName,
         @Query('sitting_number') String?  sittingNumber,
     });

     @GET('/api/favorites/{countryId}')
     Future<BaseResponse<int>> addFavorite({
         @Path('countryId') required int  countryId,
     });

     @PUT('/api/update/user')
     Future<BaseResponse<DeviceSettingsModel?>> updateUser({
         @Path('firebase_token') required int  firebaseToken,
     });

 }
