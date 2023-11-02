// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment2_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddComment2Request _$AddComment2RequestFromJson(Map<String, dynamic> json) =>
    AddComment2Request(
      storyId2: json['storyId2'] as String? ?? "storyId2",
      content2: json['content2'] as String? ?? "content2",
    );

Map<String, dynamic> _$AddComment2RequestToJson(AddComment2Request instance) =>
    <String, dynamic>{
      'storyId2': instance.storyId2,
      'content2': instance.content2,
    };
