import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:injectable/injectable.dart';
part 'add_comment4_request.g.dart';

///[AddComment4Request]
///[Implementation]
@injectable
@JsonSerializable()
class AddComment4Request {
String storyId;
String content;
AddComment4Request({
this.storyId = "storyId", 
this.content = "content", 
});





























































factory AddComment4Request.fromJson(Map<String, dynamic> json) => _$AddComment4RequestFromJson(json);
Map<String, dynamic> toJson() => _$AddComment4RequestToJson(this);




























































}
