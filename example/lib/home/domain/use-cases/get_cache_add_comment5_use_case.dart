import 'dart:ffi';

import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';

///[GetCacheAddComment5UseCase]
///[Implementation]
@injectable
class GetCacheAddComment5UseCase
    implements BaseUseCase<Void?, Either<Failure, DeviceSettingsEntity>> {
  final HomeRepository repository;

  const GetCacheAddComment5UseCase(
    this.repository,
  );

  @override
  Either<Failure, DeviceSettingsEntity> execute({
    Void? request,
  }) {
    return repository.getCacheAddComment5();
  }
}
