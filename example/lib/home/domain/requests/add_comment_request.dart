import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_comment_request.g.dart';

///[AddCommentRequest]
///[Implementation]
@injectable
@JsonSerializable()
class AddCommentRequest {
  String storyId1;
  String content1;

  AddCommentRequest({
    this.storyId1 = "storyId1",
    this.content1 = "content1",
  });

  factory AddCommentRequest.fromJson(Map<String, dynamic> json) =>
      _$AddCommentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddCommentRequestToJson(this);
}
