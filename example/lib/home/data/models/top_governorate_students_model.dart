import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/domain/entities/top_governorate_students_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'top_governorate_students_model.g.dart';

@JsonSerializable()
class TopGovernorateStudentsModel  implements TopGovernorateStudentsEntity {
@override
@JsonKey(name: "studentName",defaultValue: "")
final String studentName;
@override
@JsonKey(name: "percentage",defaultValue: 0.0)
final double percentage;
@override
@JsonKey(name: "school",defaultValue: "")
final String school;
const TopGovernorateStudentsModel({
required this.studentName,
required this.percentage,
required this.school,
 });

factory TopGovernorateStudentsModel.fromJson(Map<String, dynamic> json) =>
 _$TopGovernorateStudentsModelFromJson(json);

Map<String, dynamic> toJson() => _$TopGovernorateStudentsModelToJson(this);

}

