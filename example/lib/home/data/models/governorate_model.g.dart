// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'governorate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GovernorateModel _$GovernorateModelFromJson(Map<String, dynamic> json) =>
    GovernorateModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      isFavourite: json['isFavourite'] as bool? ?? false,
      availableResults: (json['availableResults'] as List<dynamic>?)
              ?.map((e) =>
                  AvailableResultsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GovernorateModelToJson(GovernorateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isFavourite': instance.isFavourite,
      'availableResults': instance.availableResults,
    };
