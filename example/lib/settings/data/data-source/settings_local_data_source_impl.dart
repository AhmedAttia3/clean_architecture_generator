import 'package:eitherx/eitherx.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'dart:convert';import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/settings/data/data-source/settings_local_data_source.dart';

///[SettingsLocalDataSourceImpl]
///[Implementation]
@Injectable(as:SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
final SharedPreferences sharedPreferences;
const SettingsLocalDataSourceImpl(
this.sharedPreferences,
);

final _savedProducts = "SAVEDPRODUCTS";
@override
Future<Either<Failure, Unit>> cacheSavedProducts({required List<ProductModel> data,}) async {
try {
await sharedPreferences.setString(_savedProducts,jsonEncode(data.map((item)=> item.toJson()).toList()));
return const Right(unit);
} catch (e) {
return Left(Failure(999, 'Cache failure'));
}
}

@override
Either<Failure, List<ProductModel>> getCacheSavedProducts(){
try {
final res = sharedPreferences.getString(_savedProducts) ?? "{}";
List<ProductModel> data = [];
for (var item in jsonDecode(res)) {
data.add(ProductModel.fromJson(item));
}
return Right(data);
} catch (e) {
return Left(Failure(999, 'Cache failure'));
}
}

final _settings = "SETTINGS";
@override
Future<Either<Failure, Unit>> cacheSettings({required SettingsModel data,}) async {
try {
await sharedPreferences.setString(_settings, jsonEncode(data.toJson()));
return const Right(unit);
} catch (e) {
return Left(Failure(999, 'Cache failure'));
}
}

@override
Either<Failure, SettingsModel> getCacheSettings(){
try {
final res = sharedPreferences.getString(_settings) ?? "{}";
return Right(SettingsModel.fromJson(jsonDecode(res)));
} catch (e) {
return Left(Failure(999, 'Cache failure'));
}
}

}

