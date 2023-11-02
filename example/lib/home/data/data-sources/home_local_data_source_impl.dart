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

  final _addComment5 = "ADDCOMMENT5";

  @override
  Future<Either<Failure, Unit>> cacheAddComment5({
    required DeviceSettingsModel data,
  }) async {
    try {
      await sharedPreferences.setString(
          _addComment5, jsonEncode(data.toJson()));
      return const Right(unit);
    } catch (e) {
      return Left(Failure(999, 'Cache failure'));
    }
  }

  @override
  Either<Failure, DeviceSettingsModel> getCacheAddComment5() {
    try {
      final res = sharedPreferences.getString(_addComment5) ?? "{}";
      return Right(DeviceSettingsModel.fromJson(jsonDecode(res)));
    } catch (e) {
      return Left(Failure(999, 'Cache failure'));
    }
  }

  final _addComment6 = "ADDCOMMENT6";

  @override
  Future<Either<Failure, Unit>> cacheAddComment6({
    required DeviceSettingsModel data,
  }) async {
    try {
      await sharedPreferences.setString(
          _addComment6, jsonEncode(data.toJson()));
      return const Right(unit);
    } catch (e) {
      return Left(Failure(999, 'Cache failure'));
    }
  }

  @override
  Either<Failure, DeviceSettingsModel> getCacheAddComment6() {
    try {
      final res = sharedPreferences.getString(_addComment6) ?? "{}";
      return Right(DeviceSettingsModel.fromJson(jsonDecode(res)));
    } catch (e) {
      return Left(Failure(999, 'Cache failure'));
    }
  }

  final _addComment7 = "ADDCOMMENT7";

  @override
  Future<Either<Failure, Unit>> cacheAddComment7({
    required DeviceSettingsModel data,
  }) async {
    try {
      await sharedPreferences.setString(
          _addComment7, jsonEncode(data.toJson()));
      return const Right(unit);
    } catch (e) {
      return Left(Failure(999, 'Cache failure'));
    }
  }

  @override
  Either<Failure, DeviceSettingsModel> getCacheAddComment7() {
    try {
      final res = sharedPreferences.getString(_addComment7) ?? "{}";
      return Right(DeviceSettingsModel.fromJson(jsonDecode(res)));
    } catch (e) {
      return Left(Failure(999, 'Cache failure'));
    }
  }
}
