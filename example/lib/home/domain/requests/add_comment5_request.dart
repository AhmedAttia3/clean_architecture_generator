import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_comment5_request.g.dart';

///[AddComment5Request]
///[Implementation]
@injectable
@JsonSerializable()
class AddComment5Request {
  String storyId;
  String content;

  AddComment5Request({
    this.storyId = "storyId",
    this.content = "content",
  });

  factory AddComment5Request.fromJson(Map<String, dynamic> json) =>
      _$AddComment5RequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddComment5RequestToJson(this);
}
