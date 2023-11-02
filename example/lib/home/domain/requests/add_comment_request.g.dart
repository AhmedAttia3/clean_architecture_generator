// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentRequest _$AddCommentRequestFromJson(Map<String, dynamic> json) =>
    AddCommentRequest(
      storyId1: json['storyId1'] as String? ?? "storyId1",
      content1: json['content1'] as String? ?? "content1",
    );

Map<String, dynamic> _$AddCommentRequestToJson(AddCommentRequest instance) =>
    <String, dynamic>{
      'storyId1': instance.storyId1,
      'content1': instance.content1,
    };
