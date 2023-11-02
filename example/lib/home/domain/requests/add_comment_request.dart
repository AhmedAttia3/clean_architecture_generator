import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:injectable/injectable.dart';
part 'add_comment_request.g.dart';

///[AddCommentRequest]
///[Implementation]
@injectable
@JsonSerializable()
class AddCommentRequest {
String storyId1;
String content1;
AddCommentRequest({
this.storyId1 = "storyId1", 
this.content1 = "content1", 
});





































factory AddCommentRequest.fromJson(Map<String, dynamic> json) => _$AddCommentRequestFromJson(json);
Map<String, dynamic> toJson() => _$AddCommentRequestToJson(this);




































}
