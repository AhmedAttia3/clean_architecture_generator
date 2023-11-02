import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_comment7_request.g.dart';

///[AddComment7Request]
///[Implementation]
@injectable
@JsonSerializable()
class AddComment7Request {
  String storyId;
  String content;

  AddComment7Request({
    this.storyId = "storyId",
    this.content = "content",
  });

  factory AddComment7Request.fromJson(Map<String, dynamic> json) =>
      _$AddComment7RequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddComment7RequestToJson(this);
}
