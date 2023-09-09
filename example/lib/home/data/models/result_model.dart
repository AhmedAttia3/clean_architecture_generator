import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/home/data/models/result_model.dart';
import 'package:example/home/data/models/top_governorate_students_model.dart';
import 'package:example/home/data/models/top_administration_students_model.dart';
import 'package:example/home/data/models/top_school_students_model.dart';
import 'package:example/home/domain/entities/result_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'result_model.g.dart';

@JsonSerializable()
class ResultModel  implements ResultEntity {
@override
@JsonKey(name: "result",defaultValue: [])
final List<ResultModel> result;
@override
@JsonKey(name: "topGovernorateStudents",defaultValue: [])
final List<TopGovernorateStudentsModel> topGovernorateStudents;
@override
@JsonKey(name: "topAdministrationStudents",defaultValue: [])
final List<TopAdministrationStudentsModel> topAdministrationStudents;
@override
@JsonKey(name: "topSchoolStudents",defaultValue: [])
final List<TopSchoolStudentsModel> topSchoolStudents;
const ResultModel({
required this.result,
required this.topGovernorateStudents,
required this.topAdministrationStudents,
required this.topSchoolStudents,
 });

factory ResultModel.fromJson(Map<String, dynamic> json) =>
 _$ResultModelFromJson(json);

Map<String, dynamic> toJson() => _$ResultModelToJson(this);

}

