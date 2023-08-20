import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:injectable/injectable.dart';
part 'register_request.g.dart';

///[RegisterRequest]
///[Implementation]
@injectable
@JsonSerializable()
class RegisterRequest {
String fullName;
String phone;
String email;
String password;
String id;
RegisterRequest({
this.fullName="fullName",
this.phone="phone",
this.email="email",
this.password="password",
this.id="id",
});

factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

