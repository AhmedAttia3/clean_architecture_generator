import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:injectable/injectable.dart';
part 'get_otps_request.g.dart';

///[GetOTPsRequest]
///[Implementation]
@injectable
@JsonSerializable()
class GetOTPsRequest {
int page;
int limit;
String userId;
GetOTPsRequest({
this.page=0,
this.limit=0,
this.userId="userId",
});

factory GetOTPsRequest.fromJson(Map<String, dynamic> json) => _$GetOTPsRequestFromJson(json);
Map<String, dynamic> toJson() => _$GetOTPsRequestToJson(this);
}

