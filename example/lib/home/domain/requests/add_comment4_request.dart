import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

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

  factory AddComment4Request.fromJson(Map<String, dynamic> json) =>
      _$AddComment4RequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddComment4RequestToJson(this);
}
