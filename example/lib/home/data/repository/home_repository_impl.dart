import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'dart:convert';import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/data/data-sources/home_remote_data_source.dart';
import 'package:example/home/domain/entities/governorate_entity.dart';
import 'package:example/home/data/models/governorate_model.dart';
import 'package:example/home/domain/entities/result_entity.dart';
import 'package:example/home/data/models/result_model.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/core/base/base_response.dart';

///[HomeRepositoryImplement]
///[Implementation]
@Injectable(as:HomeRepository)
class HomeRepositoryImplement implements HomeRepository {
final HomeRemoteDataSource homeRemoteDataSource;
const HomeRepositoryImplement(
this.homeRemoteDataSource,
);

@override
Future<Either<Failure, BaseResponse<List<GovernorateEntity>?>>> getGovernorates()async {
return await homeRemoteDataSource.getGovernorates();
}

@override
Future<Either<Failure, BaseResponse<ResultEntity?>>> getResult({required int countryId,required int termId,required String studentName,required String sittingNumber, })async {
return await homeRemoteDataSource.getResult(countryId: countryId,termId: termId,studentName: studentName,sittingNumber: sittingNumber,);
}

@override
Future<Either<Failure, BaseResponse<int>>> addFavorite({required int countryId, })async {
return await homeRemoteDataSource.addFavorite(countryId: countryId,);
}

@override
Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> updateUser({required int firebaseToken, })async {
return await homeRemoteDataSource.updateUser(firebaseToken: firebaseToken,);
}

}

