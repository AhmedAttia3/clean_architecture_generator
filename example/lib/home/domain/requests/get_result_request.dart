import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:injectable/injectable.dart';
part 'get_result_request.g.dart';

///[GetResultRequest]
///[Implementation]
@injectable
@JsonSerializable()
class GetResultRequest {
int countryId;
int termId;
String studentName;
String sittingNumber;
GetResultRequest({
this.countryId = 0,
this.termId = 0,
this.studentName = "studentName",
this.sittingNumber = "sittingNumber",
});

factory GetResultRequest.fromJson(Map<String, dynamic> json) => _$GetResultRequestFromJson(json);
Map<String, dynamic> toJson() => _$GetResultRequestToJson(this);
}

