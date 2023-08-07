// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    SettingsModel(
      id: json['id'] as int? ?? 0,
      instagram: json['instagram'] as String? ?? '',
      snapchat: json['snapchat'] as String? ?? '',
      facebook: json['facebook'] as String? ?? '',
      twitter: json['twitter'] as String? ?? '',
      egyptianPhone: json['egyptian_phone'] as String? ?? '',
      egyptianWhatsapp: json['egyptian_whatsapp'] as String? ?? '',
      saudiPhone: json['saudi_phone'] as String? ?? '',
      saudiWhatsapp: json['saudi_whatsapp'] as String? ?? '',
    );

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'snapchat': instance.snapchat,
      'instagram': instance.instagram,
      'egyptian_phone': instance.egyptianPhone,
      'egyptian_whatsapp': instance.egyptianWhatsapp,
      'saudi_phone': instance.saudiPhone,
      'saudi_whatsapp': instance.saudiWhatsapp,
    };
