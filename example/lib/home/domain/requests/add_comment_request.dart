import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_comment_request.g.dart';

///[AddCommentRequest]
///[Implementation]
@injectable
@JsonSerializable()
class AddCommentRequest {
  String storyId;
  String content;

  AddCommentRequest({
    this.storyId = "storyId",
    this.content = "content",
  });

  factory AddCommentRequest.fromJson(Map<String, dynamic> json) =>
      _$AddCommentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddCommentRequestToJson(this);
}
