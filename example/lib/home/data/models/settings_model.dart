import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/home/data/models/governorate_model.dart';
import 'package:example/home/domain/entities/settings_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'settings_model.g.dart';

@JsonSerializable()
class SettingsModel  implements SettingsEntity {
@override
@JsonKey(name: "id",defaultValue: 0)
final int id;
@override
@JsonKey(name: "year",defaultValue: "")
final String year;
@override
@JsonKey(name: "status",defaultValue: "")
final String status;
@override
@JsonKey(name: "isSearchableByName",defaultValue: false)
final bool isSearchableByName;
@override
@JsonKey(name: "isSearchableBySittingNumber",defaultValue: false)
final bool isSearchableBySittingNumber;
@override
@JsonKey(name: "term",defaultValue: "")
final String term;
@override
@JsonKey(name: "termId",defaultValue: 0)
final int termId;
@override
@JsonKey(name: "state",defaultValue: "")
final String state;
@override
@JsonKey(name: "governorate")
final GovernorateModel? governorate;
const SettingsModel({
required this.id,
required this.year,
required this.status,
required this.isSearchableByName,
required this.isSearchableBySittingNumber,
required this.term,
required this.termId,
required this.state,
required this.governorate,
 });

factory SettingsModel.fromJson(Map<String, dynamic> json) =>
 _$SettingsModelFromJson(json);

Map<String, dynamic> toJson() => _$SettingsModelToJson(this);

}

