import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/home/data/data-sources/home_local_data_source.dart';
import 'package:example/home/data/models/device_settings_model.dart';

///[HomeLocalDataSourceImpl]
///[Implementation]
@Injectable(as:HomeLocalDataSource)
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
final SharedPreferences sharedPreferences;
const HomeLocalDataSourceImpl(
this.sharedPreferences,
);

final _updateUser = "UPDATEUSER";
@override
Future<Either<Failure, Unit>> cacheUpdateUser({required DeviceSettingsModel data,}) async {
try {
await sharedPreferences.setString(_updateUser, jsonEncode(data.toJson()));
return const Right(unit);
} catch (e) {
return Left(Failure(999, 'Cache failure'));
}
}

@override
Either<Failure, DeviceSettingsModel> getCacheUpdateUser(){
try {
final res = sharedPreferences.getString(_updateUser) ?? "{}";
return Right(DeviceSettingsModel.fromJson(jsonDecode(res)));
} catch (e) {
return Left(Failure(999, 'Cache failure'));
}
}


final _updateUser2 = "UPDATEUSER2";
Future<Either<Failure, Unit>> cacheUpdateUser2({required DeviceSettingsModel data,}) async {
await sharedPreferences.setString(_updateUser2, jsonEncode(data.toJson()));
Either<Failure, DeviceSettingsModel> getCacheUpdateUser2(){
final res = sharedPreferences.getString(_updateUser2) ?? "{}";

//[]
}
