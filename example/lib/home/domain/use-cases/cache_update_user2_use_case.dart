import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/data/models/device_settings_model.dart';

///[CacheUpdateUser2UseCase]
///[Implementation]
@injectable
class CacheUpdateUser2UseCase implements BaseUseCase<DeviceSettingsModel, Future<Either<Failure, Unit>>> {
final HomeRepository repository;
const CacheUpdateUser2UseCase(
this.repository,
);

@override
Future<Either<Failure, Unit>> execute({DeviceSettingsModel? request,}) async {
if(request != null){
return await repository.cacheUpdateUser2
(data: request);
}
return const Right(unit);
}

}

