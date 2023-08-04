import 'package:eitherx/eitherx.dart';
import 'package:example/core/failure.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';

///[Implementation]
abstract class SettingsRemoteDataSourceRepository {
  Future<Either<Failure, BaseResponse<dynamic>>> saveProduct({
    required String productId,
    required String type,
  });

  Future<Either<Failure, BaseResponse<List<ProductModel>?>>> getSavedProducts({
    required int page,
    required int limit,
  });

  Future<Either<Failure, Unit>> cacheSavedProducts({
    required List<ProductModel> data,
  });

  Either<Failure, List<ProductModel>> getCacheSavedProducts();

  Future<Either<Failure, BaseResponse<SettingsModel?>>> getSettings();

  Future<Either<Failure, Unit>> cacheSettings({
    required SettingsModel data,
  });

  Either<Failure, SettingsModel> getCacheSettings();

  Future<Either<Failure, BaseResponse<List<SettingsModel>?>>> getApp({
    required int page,
    required int limit,
  });

  Future<Either<Failure, BaseResponse<int>>> getAA();
}
