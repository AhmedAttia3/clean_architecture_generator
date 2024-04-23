import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';

///[CacheAddComment5UseCase]
///[Implementation]
@injectable
class CacheAddComment5UseCase
    implements BaseUseCase<DeviceSettingsModel, Future<Either<Failure, Unit>>> {
  final HomeRepository repository;

  const CacheAddComment5UseCase(
    this.repository,
  );

  @override
  Future<Either<Failure, Unit>> execute({
    DeviceSettingsModel? request,
  }) async {
    if (request != null) {
      return await repository.cacheAddComment5(data: request);
    }
    return const Right(unit);
  }
}
