import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/home/domain/entities/top_administration_students_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'top_administration_students_model.g.dart';

@JsonSerializable()
class TopAdministrationStudentsModel  implements TopAdministrationStudentsEntity {
@override
@JsonKey(name: "studentName",defaultValue: "")
final String studentName;
@override
@JsonKey(name: "percentage",defaultValue: 0.0)
final double percentage;
@override
@JsonKey(name: "school",defaultValue: "")
final String school;
const TopAdministrationStudentsModel({
required this.studentName,
required this.percentage,
required this.school,
 });

factory TopAdministrationStudentsModel.fromJson(Map<String, dynamic> json) =>
 _$TopAdministrationStudentsModelFromJson(json);

Map<String, dynamic> toJson() => _$TopAdministrationStudentsModelToJson(this);

}

