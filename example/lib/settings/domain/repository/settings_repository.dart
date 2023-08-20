import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
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

///[Implementation]
abstract class SettingsRepository {
Future<Either<Failure, BaseResponse<UserEntity?>>> login({required LoginRequest request,});
Future<Either<Failure, Unit>> cacheLogin({required UserModel data,});
Either<Failure, UserEntity> getCacheLogin();
Future<Either<Failure, BaseResponse<UserEntity?>>> register({required String fullName,required String phone,required String email,required String password,required String id, });
Future<Either<Failure, Unit>> cacheRegister({required UserModel data,});
Either<Failure, UserEntity> getCacheRegister();
Future<Either<Failure, BaseResponse<List<AddressEntity>?>>> getAddresses({required int page,required int limit,required String userId, });
Future<Either<Failure, BaseResponse<List<OtpEntity>?>>> getOTPs({required int page,required int limit,required String userId, });
Future<Either<Failure, BaseResponse<List<OtpEntity>?>>> getOtp({required int page,required int limit,required String userId, });
}

