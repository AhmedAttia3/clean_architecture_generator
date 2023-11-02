import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:injectable/injectable.dart';
part 'add_comment8_request.g.dart';

///[AddComment8Request]
///[Implementation]
@injectable
@JsonSerializable()
class AddComment8Request {
String storyId3;
String content3;
AddComment8Request({
this.storyId3 = "storyId3", 
this.content3 = "content3", 
});



































factory AddComment8Request.fromJson(Map<String, dynamic> json) => _$AddComment8RequestFromJson(json);
Map<String, dynamic> toJson() => _$AddComment8RequestToJson(this);


































}
