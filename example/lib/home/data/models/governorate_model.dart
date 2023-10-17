import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:injectable/injectable.dart';
import 'package:example/home/data/models/available_results_model.dart';
import 'package:example/home/domain/entities/governorate_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'governorate_model.g.dart';

@JsonSerializable()
class GovernorateModel  implements GovernorateEntity {
@override
@JsonKey(name: "id",defaultValue: 0)
final int id;
@override
@JsonKey(name: "name",defaultValue: "")
final String name;
@override
@JsonKey(name: "isFavourite",defaultValue: false)
final bool isFavourite;
@override
@JsonKey(name: "availableResults",defaultValue: const [])
final List<AvailableResultsModel> availableResults;
const GovernorateModel({
required this.id,
required this.name,
required this.isFavourite,
required this.availableResults,
 });

factory GovernorateModel.fromJson(Map<String, dynamic> json) =>
 _$GovernorateModelFromJson(json);

Map<String, dynamic> toJson() => _$GovernorateModelToJson(this);

}

