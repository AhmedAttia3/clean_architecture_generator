import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'dart:convert';import 'package:shared_preferences/shared_preferences.dart';

///[Implementation]
abstract class SettingsLocalDataSource {
Future<Either<Failure, Unit>> cacheSettings({required SettingsModel data,});
Either<Failure, SettingsModel> getCacheSettings();
}

