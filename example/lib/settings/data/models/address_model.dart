import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/domain/entities/address_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'address_model.g.dart';

@JsonSerializable()
class AddressModel  implements AddressEntity {
@override
@JsonKey(name: "id",defaultValue: 0)
final int id;
@override
@JsonKey(name: "name",defaultValue: "")
final String name;
const AddressModel({
required this.id,
required this.name,
 });

factory AddressModel.fromJson(Map<String, dynamic> json) =>
 _$AddressModelFromJson(json);

Map<String, dynamic> toJson() => _$AddressModelToJson(this);

}

