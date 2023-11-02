// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment2_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddComment2Request _$AddComment2RequestFromJson(Map<String, dynamic> json) =>
    AddComment2Request(
      storyId: json['storyId'] as String? ?? "storyId",
      content: json['content'] as String? ?? "content",
    );

Map<String, dynamic> _$AddComment2RequestToJson(AddComment2Request instance) =>
    <String, dynamic>{
      'storyId': instance.storyId,
      'content': instance.content,
    };
