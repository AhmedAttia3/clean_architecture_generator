// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment6_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddComment6Request _$AddComment6RequestFromJson(Map<String, dynamic> json) =>
    AddComment6Request(
      storyId: json['storyId'] as String? ?? "storyId",
      content: json['content'] as String? ?? "content",
    );

Map<String, dynamic> _$AddComment6RequestToJson(AddComment6Request instance) =>
    <String, dynamic>{
      'storyId': instance.storyId,
      'content': instance.content,
    };
