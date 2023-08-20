import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/address_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/settings/data/models/otp_model.dart';

///[Implementation]
abstract class SettingsLocalDataSource {
Future<Either<Failure, Unit>> cacheLogin({required UserModel data,});
Either<Failure, UserModel> getCacheLogin();
Future<Either<Failure, Unit>> cacheRegister({required UserModel data,});
Either<Failure, UserModel> getCacheRegister();
}

