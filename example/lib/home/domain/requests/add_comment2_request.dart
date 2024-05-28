import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:injectable/injectable.dart';
part 'add_comment2_request.g.dart';

///[AddComment2Request]
///[Implementation]
@injectable
@JsonSerializable()
class AddComment2Request {
String storyId2;
String content2;
AddComment2Request({
this.storyId2 = "storyId2", 
this.content2 = "content2", 
});





























































factory AddComment2Request.fromJson(Map<String, dynamic> json) => _$AddComment2RequestFromJson(json);
Map<String, dynamic> toJson() => _$AddComment2RequestToJson(this);




























































}
