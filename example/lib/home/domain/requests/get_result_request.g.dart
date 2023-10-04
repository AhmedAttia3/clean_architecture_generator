// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_result_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetResultRequest _$GetResultRequestFromJson(Map<String, dynamic> json) =>
    GetResultRequest(
      countryId: json['countryId'] as int? ?? 0,
      termId: json['termId'] as int? ?? 0,
      studentName: json['studentName'] as String? ?? "studentName",
      sittingNumber: json['sittingNumber'] as String? ?? "sittingNumber",
    );

Map<String, dynamic> _$GetResultRequestToJson(GetResultRequest instance) =>
    <String, dynamic>{
      'countryId': instance.countryId,
      'termId': instance.termId,
      'studentName': instance.studentName,
      'sittingNumber': instance.sittingNumber,
    };
