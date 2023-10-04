import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';

class DeviceSettingsEntity {
final String deviceId;
final String deviceType;
final String firebaseToken;
const DeviceSettingsEntity({
required this.deviceId,
required this.deviceType,
required this.firebaseToken,
 });

}

