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
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';

///[HomeLocalDataSourceImpl]
///[Implementation]
@Injectable(as:HomeLocalDataSource)
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






































}
