import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_comment3_request.g.dart';

///[AddComment3Request]
///[Implementation]
@injectable
@JsonSerializable()
class AddComment3Request {
  String storyId;
  String content;

  AddComment3Request({
    this.storyId = "storyId",
    this.content = "content",
  });

  factory AddComment3Request.fromJson(Map<String, dynamic> json) =>
      _$AddComment3RequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddComment3RequestToJson(this);
}
