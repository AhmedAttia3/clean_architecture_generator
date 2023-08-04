// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveProductRequest _$SaveProductRequestFromJson(Map<String, dynamic> json) =>
    SaveProductRequest(
      productId: json['productId'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$SaveProductRequestToJson(SaveProductRequest instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'type': instance.type,
    };
