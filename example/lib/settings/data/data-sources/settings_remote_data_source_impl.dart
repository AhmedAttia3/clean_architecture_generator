import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'dart:convert';import 'package:example/core/safe_request_handler.dart';
import 'package:example/core/fold.dart';
import 'package:example/settings/data/client-services/settings_client_services.dart';
import 'package:example/settings/data/data-sources/settings_remote_data_source.dart';
import 'package:example/settings/domain/requests/login_request.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/address_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/core/base_response.dart';

///[SettingsRemoteDataSource]
///[Implementation]
@Injectable(as:SettingsRemoteDataSource)
class SettingsRemoteDataSourceImplement implements SettingsRemoteDataSource {
final SettingsClientServices settingsClientServices;
final SafeApi api;
const SettingsRemoteDataSourceImplement(
this.settingsClientServices,
this.api,
);

@override
Future<Either<Failure, BaseResponse<UserModel?>>> login({required LoginRequest request,})async {
return await api<BaseResponse<UserModel?>>(
apiCall: settingsClientServices.login(
request: request,),);
}

@override
Future<Either<Failure, BaseResponse<UserModel?>>> register({required String fullName,required String phone,required String email,required String password,required String id, })async {
return await api<BaseResponse<UserModel?>>(
apiCall: settingsClientServices.register(fullName: fullName,phone: phone,email: email,password: password,id: id,),);
}

@override
Future<Either<Failure, BaseResponse<List<AddressModel>?>>> getAddresses({required int page,required int limit,required String userId, })async {
return await api<BaseResponse<List<AddressModel>?>>(
apiCall: settingsClientServices.getAddresses(page: page,limit: limit,userId: userId,),);
}

@override
Future<Either<Failure, BaseResponse<List<OtpModel>?>>> getOTPs({required int page,required int limit,required String userId, })async {
return await api<BaseResponse<List<OtpModel>?>>(
apiCall: settingsClientServices.getOTPs(page: page,limit: limit,userId: userId,),);
}

@override
Future<Either<Failure, BaseResponse<List<OtpModel>?>>> getOtp({required int page,required int limit,required String userId, })async {
return await api<BaseResponse<List<OtpModel>?>>(
apiCall: settingsClientServices.getOtp(page: page,limit: limit,userId: userId,),);
}

}

