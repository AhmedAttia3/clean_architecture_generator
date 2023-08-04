// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    SettingsModel(
      id: json['_id'] as String? ?? '',
      privacy: json['privacy'] as String? ?? '',
      terms: json['terms'] as String? ?? '',
      about: json['about'] as String? ?? '',
    );

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'privacy': instance.privacy,
      'terms': instance.terms,
      'about': instance.about,
    };
