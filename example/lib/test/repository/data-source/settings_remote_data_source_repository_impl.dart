import 'package:eitherx/eitherx.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'dart:convert';import 'package:example/core/cubit/safe_request_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/test/repository/data-source/settings_remote_data_source_repository.dart';
import 'package:example/test/settings_remote_data_source.dart';

///[SettingsRemoteDataSourceRepositoryImplement]
///[Implementation]
@Injectable(as:SettingsRemoteDataSourceRepository)
class SettingsRemoteDataSourceRepositoryImplement implements SettingsRemoteDataSourceRepository {
final SettingsRemoteDataSource settingsRemoteDataSource;
final SafeApi api;
final SharedPreferences sharedPreferences;
const SettingsRemoteDataSourceRepositoryImplement(
this.settingsRemoteDataSource,
this.api,
this.sharedPreferences,
);

@override
Future<Either<Failure, BaseResponse<dynamic>>> saveProduct({required String productId,required String type, })async {
return await api<BaseResponse<dynamic>>(
apiCall: settingsRemoteDataSource.saveProduct(productId: productId,type: type,),);
}

@override
Future<Either<Failure, double>> getSavedProducts({required int page,required int limit, })async {
return await api<double>(
apiCall: settingsRemoteDataSource.getSavedProducts(page: page,limit: limit,),);
}

final _savedProducts = "SAVEDPRODUCTS";
@override
Future<Either<Failure, Unit>> cacheSavedProducts({required double data,}) async {
try {
await sharedPreferences.setString(_savedProducts, jsonEncode(data.toJson()));
return const Right(unit);
} catch (e) {
return Left(Failure(12, 'Cash failure'));
}
}

@override
Either<Failure, double> getCacheSavedProducts(){
try {
final res = sharedPreferences.getString(_savedProducts) ?? '{}';
return Right(double.fromJson(jsonDecode(res)));
} catch (e) {
return Left(Failure(12, 'Cash failure'));
}
}

@override
Future<Either<Failure, BaseResponse<InvalidType>>> getSettings()async {
return await api<BaseResponse<InvalidType>>(
apiCall: settingsRemoteDataSource.getSettings(),);
}

@override
Future<Either<Failure, BaseResponse<InvalidType>>> getSengs()async {
return await api<BaseResponse<InvalidType>>(
apiCall: settingsRemoteDataSource.getSengs(),);
}

@override
Future<Either<Failure, BaseResponse<List<InvalidType>?>>> getQuestions()async {
return await api<BaseResponse<List<InvalidType>?>>(
apiCall: settingsRemoteDataSource.getQuestions(),);
}

}

