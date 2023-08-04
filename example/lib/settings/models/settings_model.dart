import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@JsonSerializable()
class SettingsModel {
  @JsonKey(name: '_id', defaultValue: '')
  final String id;
  @JsonKey(defaultValue: '')
  final String privacy;
  @JsonKey(defaultValue: '')
  final String terms;
  @JsonKey(defaultValue: '')
  final String about;

  SettingsModel({
    required this.id,
    required this.privacy,
    required this.terms,
    required this.about,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);
}
