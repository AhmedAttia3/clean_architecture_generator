import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/domain/requests/login_request.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/address_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/core/base_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'settings_client_services.g.dart';

 @RestApi()
 abstract class SettingsClientServices {
 factory SettingsClientServices(Dio dio, {String baseUrl}) =
 _SettingsClientServices;
     @POST('/login')
     Future<BaseResponse<UserModel?>> login({
         @Body() required LoginRequest request,
     });

     @POST('/register')
     Future<BaseResponse<UserModel?>> register({
         @Field('full_name') required String  fullName,
         @Field('phone') required String  phone,
         @Field('email') required String  email,
         @Field('password') required String  password,
         @Query('id') required String  id,
     });

     @GET('/getAddresses')
     Future<BaseResponse<List<AddressModel>?>> getAddresses({
         @Field('page') required int  page,
         @Field('limit') required int  limit,
         @Query('userId') required String  userId,
     });

     @GET('/getOTPs')
     Future<BaseResponse<List<OtpModel>?>> getOTPs({
         @Field('page') required int  page,
         @Field('limit') required int  limit,
         @Query('userId') required String  userId,
     });

     @GET('/getOtp')
     Future<BaseResponse<List<OtpModel>?>> getOtp({
         @Field('page') required int  page,
         @Field('limit') required int  limit,
         @Query('userId') required String  userId,
     });

 }
