import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_comment6_request.g.dart';

///[AddComment6Request]
///[Implementation]
@injectable
@JsonSerializable()
class AddComment6Request {
  String storyId;
  String content;

  AddComment6Request({
    this.storyId = "storyId",
    this.content = "content",
  });

  factory AddComment6Request.fromJson(Map<String, dynamic> json) =>
      _$AddComment6RequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddComment6RequestToJson(this);
}
