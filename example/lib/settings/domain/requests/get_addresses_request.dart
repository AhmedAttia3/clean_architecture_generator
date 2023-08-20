import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:injectable/injectable.dart';
part 'get_addresses_request.g.dart';

///[GetAddressesRequest]
///[Implementation]
@injectable
@JsonSerializable()
class GetAddressesRequest {
int page;
int limit;
String userId;
GetAddressesRequest({
this.page=0,
this.limit=0,
this.userId="userId",
});

factory GetAddressesRequest.fromJson(Map<String, dynamic> json) => _$GetAddressesRequestFromJson(json);
Map<String, dynamic> toJson() => _$GetAddressesRequestToJson(this);
}

