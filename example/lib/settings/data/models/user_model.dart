import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/data/models/address_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel  implements UserEntity {
@override
@JsonKey(name: "id",defaultValue: 0)
final int id;
@override
@JsonKey(name: "name",defaultValue: "")
final String name;
@override
@JsonKey(name: "address")
final AddressModel? address;
@override
@JsonKey(name: "wallet",defaultValue: 0.0)
final double wallet;
@override
@JsonKey(name: "items",defaultValue: [])
final List<dynamic> items;
@override
@JsonKey(name: "otp",defaultValue: [])
final List<OtpModel> otp;
const UserModel({
required this.id,
required this.name,
required this.address,
required this.wallet,
required this.items,
required this.otp,
 });

factory UserModel.fromJson(Map<String, dynamic> json) =>
 _$UserModelFromJson(json);

Map<String, dynamic> toJson() => _$UserModelToJson(this);

}

