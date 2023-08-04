// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_saved_products_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSavedProductsRequest _$GetSavedProductsRequestFromJson(
        Map<String, dynamic> json) =>
    GetSavedProductsRequest(
      page: json['page'] as int,
      limit: json['limit'] as int,
    );

Map<String, dynamic> _$GetSavedProductsRequestToJson(
        GetSavedProductsRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
    };
