import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/settings/data/data-sources/settings_local_data_source.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/address_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/settings/data/models/otp_model.dart';

///[SettingsLocalDataSourceImpl]
///[Implementation]
@Injectable(as:SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
final SharedPreferences sharedPreferences;
const SettingsLocalDataSourceImpl(
this.sharedPreferences,
);

final _login = "LOGIN";
@override
Future<Either<Failure, Unit>> cacheLogin({required UserModel data,}) async {
try {
await sharedPreferences.setString(_login, jsonEncode(data.toJson()));
return const Right(unit);
} catch (e) {
return Left(Failure(999, 'Cache failure'));
}
}

@override
Either<Failure, UserModel> getCacheLogin(){
try {
final res = sharedPreferences.getString(_login) ?? "{}";
return Right(UserModel.fromJson(jsonDecode(res)));
} catch (e) {
return Left(Failure(999, 'Cache failure'));
}
}

final _register = "REGISTER";
@override
Future<Either<Failure, Unit>> cacheRegister({required UserModel data,}) async {
try {
await sharedPreferences.setString(_register, jsonEncode(data.toJson()));
return const Right(unit);
} catch (e) {
return Left(Failure(999, 'Cache failure'));
}
}

@override
Either<Failure, UserModel> getCacheRegister(){
try {
final res = sharedPreferences.getString(_register) ?? "{}";
return Right(UserModel.fromJson(jsonDecode(res)));
} catch (e) {
return Left(Failure(999, 'Cache failure'));
}
}

}

