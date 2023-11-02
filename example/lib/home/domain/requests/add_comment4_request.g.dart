// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment4_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddComment4Request _$AddComment4RequestFromJson(Map<String, dynamic> json) =>
    AddComment4Request(
      storyId: json['storyId'] as String? ?? "storyId",
      content: json['content'] as String? ?? "content",
    );

Map<String, dynamic> _$AddComment4RequestToJson(AddComment4Request instance) =>
    <String, dynamic>{
      'storyId': instance.storyId,
      'content': instance.content,
    };
