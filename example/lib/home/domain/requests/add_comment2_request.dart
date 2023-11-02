import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_comment2_request.g.dart';

///[AddComment2Request]
///[Implementation]
@injectable
@JsonSerializable()
class AddComment2Request {
  String storyId;
  String content;

  AddComment2Request({
    this.storyId = "storyId",
    this.content = "content",
  });

  factory AddComment2Request.fromJson(Map<String, dynamic> json) =>
      _$AddComment2RequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddComment2RequestToJson(this);
}
