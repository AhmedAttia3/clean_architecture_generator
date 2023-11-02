import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'device_settings_model.g.dart';

@JsonSerializable()
class DeviceSettingsModel  implements DeviceSettingsEntity {
@override
@JsonKey(name: "device_id",defaultValue: "")
final String deviceId;
@override
@JsonKey(name: "device_type",defaultValue: "")
final String deviceType;
@override
@JsonKey(name: "firebase_token",defaultValue: "")
final String firebaseToken;
const DeviceSettingsModel({
required this.deviceId,
required this.deviceType,
required this.firebaseToken,
 });

factory DeviceSettingsModel.fromJson(Map<String, dynamic> json) =>
 _$DeviceSettingsModelFromJson(json);

Map<String, dynamic> toJson() => _$DeviceSettingsModelToJson(this);

}

