import 'dart:convert';

import 'package:eitherx/eitherx.dart';
import 'package:example/home/data/data-sources/home_local_data_source.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

///[HomeLocalDataSourceImpl]
///[Implementation]
@Injectable(as: HomeLocalDataSource)
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final SharedPreferences sharedPreferences;

  const HomeLocalDataSourceImpl(
    this.sharedPreferences,
  );

  final _updateUser = "UPDATEUSER";

  @override
  Future<Either<Failure, Unit>> cacheUpdateUser({
    required DeviceSettingsModel data,
  }) async {
    try {
      await sharedPreferences.setString(_updateUser, jsonEncode(data.toJson()));
      return const Right(unit);
    } catch (e) {
      return Left(Failure(999, 'Cache failure'));
    }
  }

  @override
  Either<Failure, DeviceSettingsModel> getCacheUpdateUser() {
    try {
      final res = sharedPreferences.getString(_updateUser) ?? "{}";
      return Right(DeviceSettingsModel.fromJson(jsonDecode(res)));
    } catch (e) {
      return Left(Failure(999, 'Cache failure'));
    }
  }
}
