import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'otp_model.g.dart';

@JsonSerializable()
class OtpModel  implements OtpEntity {
@override
@JsonKey(name: "id",defaultValue: 0)
final int id;
@override
@JsonKey(name: "code",defaultValue: 0)
final int code;
const OtpModel({
required this.id,
required this.code,
 });

factory OtpModel.fromJson(Map<String, dynamic> json) =>
 _$OtpModelFromJson(json);

Map<String, dynamic> toJson() => _$OtpModelToJson(this);

}

