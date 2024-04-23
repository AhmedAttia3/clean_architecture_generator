import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

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

  factory AddComment2Request.fromJson(Map<String, dynamic> json) =>
      _$AddComment2RequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddComment2RequestToJson(this);
}
