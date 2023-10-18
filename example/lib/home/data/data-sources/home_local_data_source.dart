import 'package:eitherx/eitherx.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:mwidgets/mwidgets.dart';

///[Implementation]
abstract class HomeLocalDataSource {
  Future<Either<Failure, Unit>> cacheUpdateUser({
    required DeviceSettingsModel data,
  });

  Either<Failure, DeviceSettingsModel> getCacheUpdateUser();
}
