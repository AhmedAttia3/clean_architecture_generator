import 'package:eitherx/eitherx.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:mwidgets/mwidgets.dart';

///[Implementation]
abstract class HomeLocalDataSource {
  Future<Either<Failure, Unit>> cacheAddComment5({
    required DeviceSettingsModel data,
  });

  Either<Failure, DeviceSettingsModel> getCacheAddComment5();

  Future<Either<Failure, Unit>> cacheAddComment6({
    required DeviceSettingsModel data,
  });

  Either<Failure, DeviceSettingsModel> getCacheAddComment6();

  Future<Either<Failure, Unit>> cacheAddComment7({
    required DeviceSettingsModel data,
  });

  Either<Failure, DeviceSettingsModel> getCacheAddComment7();
}
