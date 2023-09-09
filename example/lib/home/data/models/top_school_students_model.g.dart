// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_school_students_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopSchoolStudentsModel _$TopSchoolStudentsModelFromJson(
        Map<String, dynamic> json) =>
    TopSchoolStudentsModel(
      studentName: json['studentName'] as String? ?? '',
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      school: json['school'] as String? ?? '',
    );

Map<String, dynamic> _$TopSchoolStudentsModelToJson(
        TopSchoolStudentsModel instance) =>
    <String, dynamic>{
      'studentName': instance.studentName,
      'percentage': instance.percentage,
      'school': instance.school,
    };
