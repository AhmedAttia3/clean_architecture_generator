// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_app_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAppRequest _$GetAppRequestFromJson(Map<String, dynamic> json) =>
    GetAppRequest(
      page: json['page'] as int,
      limit: json['limit'] as int,
    );

Map<String, dynamic> _$GetAppRequestToJson(GetAppRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
    };
