// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment5_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddComment5Request _$AddComment5RequestFromJson(Map<String, dynamic> json) =>
    AddComment5Request(
      storyId: json['storyId'] as String? ?? "storyId",
      content: json['content'] as String? ?? "content",
    );

Map<String, dynamic> _$AddComment5RequestToJson(AddComment5Request instance) =>
    <String, dynamic>{
      'storyId': instance.storyId,
      'content': instance.content,
    };
