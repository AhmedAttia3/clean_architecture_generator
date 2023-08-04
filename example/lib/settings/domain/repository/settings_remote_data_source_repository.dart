import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';

///[Implementation]
abstract class SettingsRemoteDataSourceRepository {
Future<Either<Failure, BaseResponse<dynamic>>> saveProduct({required String productId,required String type, });
Future<Either<Failure, BaseResponse<ProductModel?>>> getSavedProducts({required int page,required int limit, });
Future<Either<Failure, BaseResponse<SettingsModel?>>> getSettings();
Future<Either<Failure, Unit>> cacheSettings({required SettingsModel data,});
Either<Failure, SettingsModel> getCacheSettings();
}

