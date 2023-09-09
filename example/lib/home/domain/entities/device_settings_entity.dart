import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';

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

