// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_results_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableResultsModel _$AvailableResultsModelFromJson(
        Map<String, dynamic> json) =>
    AvailableResultsModel(
      id: json['id'] as int? ?? 0,
      year: json['year'] as String? ?? '',
      status: json['status'] as String? ?? '',
      isSearchableByName: json['isSearchableByName'] as bool? ?? false,
      isSearchableBySittingNumber:
          json['isSearchableBySittingNumber'] as bool? ?? false,
      term: json['term'] as String? ?? '',
      termId: json['termId'] as int? ?? 0,
      state: json['state'] as String? ?? '',
    );

Map<String, dynamic> _$AvailableResultsModelToJson(
        AvailableResultsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'status': instance.status,
      'isSearchableByName': instance.isSearchableByName,
      'isSearchableBySittingNumber': instance.isSearchableBySittingNumber,
      'term': instance.term,
      'termId': instance.termId,
      'state': instance.state,
    };
