import 'package:eitherx/eitherx.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:mwidgets/mwidgets.dart';

///[Implementation]
abstract class HomeRepository {
  Future<Either<Failure, Unit>> cacheUpdateUser({
    required DeviceSettingsModel data,
  });

  Either<Failure, DeviceSettingsEntity> getCacheUpdateUser();
}
