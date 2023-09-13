// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_governorate_students_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopGovernorateStudentsModel _$TopGovernorateStudentsModelFromJson(
        Map<String, dynamic> json) =>
    TopGovernorateStudentsModel(
      studentName: json['studentName'] as String? ?? '',
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      school: json['school'] as String? ?? '',
    );

Map<String, dynamic> _$TopGovernorateStudentsModelToJson(
        TopGovernorateStudentsModel instance) =>
    <String, dynamic>{
      'studentName': instance.studentName,
      'percentage': instance.percentage,
      'school': instance.school,
    };
