import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'dart:ffi';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/data/models/device_settings_model.dart';

///[GetCacheUpdateUser2UseCase]
///[Implementation]
@injectable
class GetCacheUpdateUser2UseCase implements BaseUseCase<Void?, Either<Failure, DeviceSettingsEntity>>{
final HomeRepository repository;
const GetCacheUpdateUser2UseCase(
this.repository,
);

@override
Either<Failure, DeviceSettingsEntity> execute({Void? request,}) {
return repository.getCacheUpdateUser2();
}

}

