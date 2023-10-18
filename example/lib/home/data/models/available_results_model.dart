import 'package:example/home/domain/entities/available_results_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'available_results_model.g.dart';

@JsonSerializable()
class AvailableResultsModel implements AvailableResultsEntity {
  @override
  @JsonKey(name: "id", defaultValue: 0)
  final int id;
  @override
  @JsonKey(name: "year", defaultValue: "")
  final String year;
  @override
  @JsonKey(name: "status", defaultValue: "")
  final String status;
  @override
  @JsonKey(name: "isSearchableByName", defaultValue: false)
  final bool isSearchableByName;
  @override
  @JsonKey(name: "isSearchableBySittingNumber", defaultValue: false)
  final bool isSearchableBySittingNumber;
  @override
  @JsonKey(name: "term", defaultValue: "")
  final String term;
  @override
  @JsonKey(name: "termId", defaultValue: 0)
  final int termId;
  @override
  @JsonKey(name: "state", defaultValue: "")
  final String state;

  const AvailableResultsModel({
    required this.id,
    required this.year,
    required this.status,
    required this.isSearchableByName,
    required this.isSearchableBySittingNumber,
    required this.term,
    required this.termId,
    required this.state,
  });

  factory AvailableResultsModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableResultsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableResultsModelToJson(this);
}
