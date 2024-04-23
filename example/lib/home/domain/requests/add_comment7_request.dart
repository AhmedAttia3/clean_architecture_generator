import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_comment7_request.g.dart';

///[AddComment7Request]
///[Implementation]
@injectable
@JsonSerializable()
class AddComment7Request {
  String storyId2;
  String content2;

  AddComment7Request({
    this.storyId2 = "storyId2",
    this.content2 = "content2",
  });

  factory AddComment7Request.fromJson(Map<String, dynamic> json) =>
      _$AddComment7RequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddComment7RequestToJson(this);
}
