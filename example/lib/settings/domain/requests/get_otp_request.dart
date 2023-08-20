import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:injectable/injectable.dart';
part 'get_otp_request.g.dart';

///[GetOtpRequest]
///[Implementation]
@injectable
@JsonSerializable()
class GetOtpRequest {
int page;
int limit;
String userId;
GetOtpRequest({
this.page=0,
this.limit=0,
this.userId="userId",
});

factory GetOtpRequest.fromJson(Map<String, dynamic> json) => _$GetOtpRequestFromJson(json);
Map<String, dynamic> toJson() => _$GetOtpRequestToJson(this);
}

