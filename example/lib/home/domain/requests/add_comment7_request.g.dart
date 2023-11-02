// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment7_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddComment7Request _$AddComment7RequestFromJson(Map<String, dynamic> json) =>
    AddComment7Request(
      storyId: json['storyId'] as String? ?? "storyId",
      content: json['content'] as String? ?? "content",
    );

Map<String, dynamic> _$AddComment7RequestToJson(AddComment7Request instance) =>
    <String, dynamic>{
      'storyId': instance.storyId,
      'content': instance.content,
    };
