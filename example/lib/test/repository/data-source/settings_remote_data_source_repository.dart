import 'package:eitherx/eitherx.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';

///[Implementation]
abstract class SettingsRemoteDataSourceRepository {
Future<Either<Failure, BaseResponse<dynamic>>> saveProduct({required String productId,required String type, });
Future<Either<Failure, double>> getSavedProducts({required int page,required int limit, });
Future<Either<Failure, Unit>> cacheSavedProducts({required double data,});
Either<Failure, double> getCacheSavedProducts();
Future<Either<Failure, BaseResponse<InvalidType>>> getSettings();
Future<Either<Failure, BaseResponse<InvalidType>>> getSengs();
Future<Either<Failure, BaseResponse<List<InvalidType>?>>> getQuestions();
}

