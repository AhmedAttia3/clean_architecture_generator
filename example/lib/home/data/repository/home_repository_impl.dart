import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'dart:convert';import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/data/data-sources/home_local_data_source.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/core/base/base_response.dart';

///[HomeRepositoryImplement]
///[Implementation]
@Injectable(as:HomeRepository)
class HomeRepositoryImplement implements HomeRepository {
final HomeLocalDataSource homeLocalDataSource;
const HomeRepositoryImplement(
this.homeLocalDataSource,
);

@override
Future<Either<Failure, Unit>> cacheUpdateUser({required DeviceSettingsModel data,}) async {
return await homeLocalDataSource.cacheUpdateUser(data: data);
}

@override
Either<Failure, DeviceSettingsEntity> getCacheUpdateUser(){
return homeLocalDataSource.getCacheUpdateUser();
}


Future<Either<Failure, Unit>> cacheUpdateUser2({required DeviceSettingsModel data,}) async {
return await homeLocalDataSource.cacheUpdateUser2(data: data);
Either<Failure, DeviceSettingsEntity> getCacheUpdateUser2(){
return homeLocalDataSource.getCacheUpdateUser2();

//[]
}
