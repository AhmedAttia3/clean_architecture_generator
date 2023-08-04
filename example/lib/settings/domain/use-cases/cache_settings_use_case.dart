import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/settings/domain/repository/settings_remote_data_source_repository.dart';

///[CacheSettingsUseCase]
///[Implementation]
@injectable
class CacheSettingsUseCase implements BaseUseCase<Future<Either<Failure, Unit>>,SettingsModel> {
final SettingsRemoteDataSourceRepository repository;
const CacheSettingsUseCase(
this.repository,
);

@override
Future<Either<Failure, Unit>> execute({SettingsModel? request,}) async {
if(request != null){
return await repository.cacheSettings
(data: request);
}
return const Right(unit);
}

}

