import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@JsonSerializable()
class SettingsModel {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String facebook;
  @JsonKey(defaultValue: '')
  final String twitter;
  @JsonKey(defaultValue: '')
  final String snapchat;
  @JsonKey(defaultValue: '')
  final String instagram;
  @JsonKey(name: 'egyptian_phone', defaultValue: '')
  final String egyptianPhone;
  @JsonKey(name: 'egyptian_whatsapp', defaultValue: '')
  final String egyptianWhatsapp;
  @JsonKey(name: 'saudi_phone', defaultValue: '')
  final String saudiPhone;
  @JsonKey(name: 'saudi_whatsapp', defaultValue: '')
  final String saudiWhatsapp;

  const SettingsModel({
    required this.id,
    required this.instagram,
    required this.snapchat,
    required this.facebook,
    required this.twitter,
    required this.egyptianPhone,
    required this.egyptianWhatsapp,
    required this.saudiPhone,
    required this.saudiWhatsapp,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);
}
