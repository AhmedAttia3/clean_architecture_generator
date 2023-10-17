import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'dart:convert';import 'package:example/home/data/client-services/home_client_services.dart';
import 'package:example/home/data/data-sources/home_remote_data_source.dart';
import 'package:example/home/data/models/governorate_model.dart';
import 'package:example/home/data/models/result_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/core/base/safe_request_handler.dart';
import 'package:example/core/base/base_response.dart';

///[HomeRemoteDataSource]
///[Implementation]
@Injectable(as:HomeRemoteDataSource)
class HomeRemoteDataSourceImplement implements HomeRemoteDataSource {
final HomeClientServices homeClientServices;
final SafeApi api;
const HomeRemoteDataSourceImplement(
this.homeClientServices,
this.api,
);

@override
Future<Either<Failure, BaseResponse<List<GovernorateModel>?>>> getGovernorates()async {
return await api<BaseResponse<List<GovernorateModel>?>>(
apiCall: homeClientServices.getGovernorates(),);
}

@override
Future<Either<Failure, BaseResponse<ResultModel?>>> getResult({required int  countryId,int?  termId,String?  studentName,String?  sittingNumber, })async {
return await api<BaseResponse<ResultModel?>>(
apiCall: homeClientServices.getResult(countryId: countryId,termId: termId,studentName: studentName,sittingNumber: sittingNumber,),);
}

@override
Future<Either<Failure, BaseResponse<int>>> addFavorite({required int  countryId, })async {
return await api<BaseResponse<int>>(
apiCall: homeClientServices.addFavorite(countryId: countryId,),);
}

@override
Future<Either<Failure, BaseResponse<DeviceSettingsModel?>>> updateUser({required int  firebaseToken, })async {
return await api<BaseResponse<DeviceSettingsModel?>>(
apiCall: homeClientServices.updateUser(firebaseToken: firebaseToken,),);
}

}

