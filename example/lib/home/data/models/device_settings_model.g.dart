// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceSettingsModel _$DeviceSettingsModelFromJson(Map<String, dynamic> json) =>
    DeviceSettingsModel(
      deviceId: json['device_id'] as String? ?? '',
      deviceType: json['device_type'] as String? ?? '',
      firebaseToken: json['firebase_token'] as String? ?? '',
    );

Map<String, dynamic> _$DeviceSettingsModelToJson(
        DeviceSettingsModel instance) =>
    <String, dynamic>{
      'device_id': instance.deviceId,
      'device_type': instance.deviceType,
      'firebase_token': instance.firebaseToken,
    };
