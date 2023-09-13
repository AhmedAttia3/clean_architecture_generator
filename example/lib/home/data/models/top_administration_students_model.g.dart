// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_administration_students_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopAdministrationStudentsModel _$TopAdministrationStudentsModelFromJson(
        Map<String, dynamic> json) =>
    TopAdministrationStudentsModel(
      studentName: json['studentName'] as String? ?? '',
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      school: json['school'] as String? ?? '',
    );

Map<String, dynamic> _$TopAdministrationStudentsModelToJson(
        TopAdministrationStudentsModel instance) =>
    <String, dynamic>{
      'studentName': instance.studentName,
      'percentage': instance.percentage,
      'school': instance.school,
    };
