// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment3_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddComment3Request _$AddComment3RequestFromJson(Map<String, dynamic> json) =>
    AddComment3Request(
      storyId: json['storyId'] as String? ?? "storyId",
      content: json['content'] as String? ?? "content",
    );

Map<String, dynamic> _$AddComment3RequestToJson(AddComment3Request instance) =>
    <String, dynamic>{
      'storyId': instance.storyId,
      'content': instance.content,
    };
