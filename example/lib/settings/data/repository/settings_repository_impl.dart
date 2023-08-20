import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'dart:convert';import 'package:example/core/safe_request_handler.dart';
import 'package:example/core/fold.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/settings/domain/repository/settings_repository.dart';
import 'package:example/settings/domain/repository/settings_repository.dart';
import 'package:example/settings/data/data-sources/settings_remote_data_source.dart';
import 'package:example/settings/data/data-sources/settings_local_data_source.dart';
import 'package:example/settings/domain/requests/login_request.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/domain/entities/address_entity.dart';
import 'package:example/settings/data/models/address_model.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/core/base_response.dart';

///[SettingsRepositoryImplement]
///[Implementation]
@Injectable(as:SettingsRepository)
class SettingsRepositoryImplement implements SettingsRepository {
final SettingsRemoteDataSource settingsRemoteDataSource;
final SettingsLocalDataSource settingsLocalDataSource;
const SettingsRepositoryImplement(
this.settingsRemoteDataSource,
this.settingsLocalDataSource,
);

@override
Future<Either<Failure, BaseResponse<UserEntity?>>> login({required LoginRequest request,})async {
final res =  await settingsRemoteDataSource.login(request: request,);
await res.right((data) async {
if (data.success) {
settingsLocalDataSource.cacheLogin(data: data.data!);
 }});
return res;
}

@override
Future<Either<Failure, Unit>> cacheLogin({required UserModel data,}) async {
return await settingsLocalDataSource.cacheLogin(data: data);
}

@override
Either<Failure, UserEntity> getCacheLogin(){
return settingsLocalDataSource.getCacheLogin();
}

@override
Future<Either<Failure, BaseResponse<UserEntity?>>> register({required String fullName,required String phone,required String email,required String password,required String id, })async {
final res = await settingsRemoteDataSource.register(fullName: fullName,phone: phone,email: email,password: password,id: id,);
await res.right((data) async {
if (data.success) {
settingsLocalDataSource.cacheRegister(data: data.data!);
 }});
return res;
}

@override
Future<Either<Failure, Unit>> cacheRegister({required UserModel data,}) async {
return await settingsLocalDataSource.cacheRegister(data: data);
}

@override
Either<Failure, UserEntity> getCacheRegister(){
return settingsLocalDataSource.getCacheRegister();
}

@override
Future<Either<Failure, BaseResponse<List<AddressEntity>?>>> getAddresses({required int page,required int limit,required String userId, })async {
return await settingsRemoteDataSource.getAddresses(page: page,limit: limit,userId: userId,);
}

@override
Future<Either<Failure, BaseResponse<List<OtpEntity>?>>> getOTPs({required int page,required int limit,required String userId, })async {
return await settingsRemoteDataSource.getOTPs(page: page,limit: limit,userId: userId,);
}

@override
Future<Either<Failure, BaseResponse<List<OtpEntity>?>>> getOtp({required int page,required int limit,required String userId, })async {
return await settingsRemoteDataSource.getOtp(page: page,limit: limit,userId: userId,);
}

}

