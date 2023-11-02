import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:injectable/injectable.dart';
part 'add_comment6_request.g.dart';

///[AddComment6Request]
///[Implementation]
@injectable
@JsonSerializable()
class AddComment6Request {
String storyId1;
String content1;
AddComment6Request({
this.storyId1 = "storyId1", 
this.content1 = "content1", 
});





































factory AddComment6Request.fromJson(Map<String, dynamic> json) => _$AddComment6RequestFromJson(json);
Map<String, dynamic> toJson() => _$AddComment6RequestToJson(this);




































}
