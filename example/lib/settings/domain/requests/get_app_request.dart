import 'package:json_annotation/json_annotation.dart';
part 'get_app_request.g.dart';
///[GetAppRequest]
///[Implementation]
@JsonSerializable()
class GetAppRequest {
final int page;
final int limit;
const GetAppRequest({
required this.page,
required this.limit,
});

factory GetAppRequest.fromJson(Map<String, dynamic> json) => _$GetAppRequestFromJson(json);
Map<String, dynamic> toJson() => _$GetAppRequestToJson(this);
}

