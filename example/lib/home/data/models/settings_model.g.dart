// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    SettingsModel(
      id: json['id'] as int? ?? 0,
      year: json['year'] as String? ?? '',
      status: json['status'] as String? ?? '',
      isSearchableByName: json['isSearchableByName'] as bool? ?? false,
      isSearchableBySittingNumber:
          json['isSearchableBySittingNumber'] as bool? ?? false,
      term: json['term'] as String? ?? '',
      termId: json['termId'] as int? ?? 0,
      state: json['state'] as String? ?? '',
      governorate: json['governorate'] == null
          ? null
          : GovernorateModel.fromJson(
              json['governorate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'status': instance.status,
      'isSearchableByName': instance.isSearchableByName,
      'isSearchableBySittingNumber': instance.isSearchableBySittingNumber,
      'term': instance.term,
      'termId': instance.termId,
      'state': instance.state,
      'governorate': instance.governorate,
    };
