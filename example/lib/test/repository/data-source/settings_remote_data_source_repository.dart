import 'package:eitherx/eitherx.dart';
import 'package:injectable/injectable.dart';

///[Implementation]
abstract class SettingsRemoteDataSourceRepository {
Future<Either<Failure, InvalidType>> saveProduct({required String productId,required String type, });
Future<Either<Failure, double>> getSavedProducts({required int page,required int limit, });
Future<Either<Failure, Unit>> cacheSavedProducts({required double data,});
Either<Failure, double> getCacheSavedProducts();
Future<Either<Failure, InvalidType>> getSettings();
Future<Either<Failure, InvalidType>> getSengs();
Future<Either<Failure, InvalidType>> getQuestions();
}

