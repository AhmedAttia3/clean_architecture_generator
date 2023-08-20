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

///[Implementation]
abstract class SettingsRemoteDataSource {
Future<Either<Failure, BaseResponse<UserModel?>>> login({required LoginRequest request,});
Future<Either<Failure, BaseResponse<UserModel?>>> register({required String fullName,required String phone,required String email,required String password,required String id, });
Future<Either<Failure, BaseResponse<List<AddressModel>?>>> getAddresses({required int page,required int limit,required String userId, });
Future<Either<Failure, BaseResponse<List<OtpModel>?>>> getOTPs({required int page,required int limit,required String userId, });
Future<Either<Failure, BaseResponse<List<OtpModel>?>>> getOtp({required int page,required int limit,required String userId, });
}

