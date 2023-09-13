// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultModel _$ResultModelFromJson(Map<String, dynamic> json) => ResultModel(
      result: (json['result'] as List<dynamic>?)
              ?.map((e) => ResultModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      topGovernorateStudents: (json['topGovernorateStudents'] as List<dynamic>?)
              ?.map((e) => TopGovernorateStudentsModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      topAdministrationStudents:
          (json['topAdministrationStudents'] as List<dynamic>?)
                  ?.map((e) => TopAdministrationStudentsModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
      topSchoolStudents: (json['topSchoolStudents'] as List<dynamic>?)
              ?.map((e) =>
                  TopSchoolStudentsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ResultModelToJson(ResultModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'topGovernorateStudents': instance.topGovernorateStudents,
      'topAdministrationStudents': instance.topAdministrationStudents,
      'topSchoolStudents': instance.topSchoolStudents,
    };
