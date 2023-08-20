import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:injectable/injectable.dart';
part 'login_request.g.dart';

///[LoginRequest]
///[Implementation]
@injectable
@JsonSerializable()
class LoginRequest {
String email;
String password;
LoginRequest({
this.email="email",
this.password="password",
});

factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

