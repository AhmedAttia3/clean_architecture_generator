import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/data/models/settings_model.dart';
import 'package:example/home/domain/entities/result_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'result_model.g.dart';

@JsonSerializable()
class ResultModel  implements ResultEntity {
@override
@JsonKey(name: "id",defaultValue: 0)
final int id;
@override
@JsonKey(name: "sittingNumber",defaultValue: 0)
final int sittingNumber;
@override
@JsonKey(name: "studentName",defaultValue: "")
final String studentName;
@override
@JsonKey(name: "school",defaultValue: "")
final String school;
@override
@JsonKey(name: "arabic",defaultValue: "")
final String arabic;
@override
@JsonKey(name: "english",defaultValue: "")
final String english;
@override
@JsonKey(name: "algebra",defaultValue: "")
final String algebra;
@override
@JsonKey(name: "engineering",defaultValue: "")
final String engineering;
@override
@JsonKey(name: "mathematics",defaultValue: null)
final Null mathematics;
@override
@JsonKey(name: "sciences",defaultValue: "")
final String sciences;
@override
@JsonKey(name: "studies",defaultValue: "")
final String studies;
@override
@JsonKey(name: "religious",defaultValue: "")
final String religious;
@override
@JsonKey(name: "art",defaultValue: "")
final String art;
@override
@JsonKey(name: "physicalEducation",defaultValue: "")
final String physicalEducation;
@override
@JsonKey(name: "firstLevel",defaultValue: null)
final Null firstLevel;
@override
@JsonKey(name: "secondLevel",defaultValue: null)
final Null secondLevel;
@override
@JsonKey(name: "englishLevel",defaultValue: null)
final Null englishLevel;
@override
@JsonKey(name: "computer",defaultValue: "")
final String computer;
@override
@JsonKey(name: "french",defaultValue: null)
final Null french;
@override
@JsonKey(name: "administration",defaultValue: null)
final Null administration;
@override
@JsonKey(name: "total",defaultValue: "")
final String total;
@override
@JsonKey(name: "percentage",defaultValue: 0.0)
final double percentage;
@override
@JsonKey(name: "status",defaultValue: null)
final Null status;
@override
@JsonKey(name: "statusNumber",defaultValue: 0)
final int statusNumber;
@override
@JsonKey(name: "termId",defaultValue: 0)
final int termId;
@override
@JsonKey(name: "governorateName",defaultValue: "")
final String governorateName;
@override
@JsonKey(name: "settings")
final SettingsModel? settings;
const ResultModel({
required this.id,
required this.sittingNumber,
required this.studentName,
required this.school,
required this.arabic,
required this.english,
required this.algebra,
required this.engineering,
required this.mathematics,
required this.sciences,
required this.studies,
required this.religious,
required this.art,
required this.physicalEducation,
required this.firstLevel,
required this.secondLevel,
required this.englishLevel,
required this.computer,
required this.french,
required this.administration,
required this.total,
required this.percentage,
required this.status,
required this.statusNumber,
required this.termId,
required this.governorateName,
required this.settings,
 });

factory ResultModel.fromJson(Map<String, dynamic> json) =>
 _$ResultModelFromJson(json);

Map<String, dynamic> toJson() => _$ResultModelToJson(this);


@JsonKey(name: "result",defaultValue: const [])
final List<ResultModel> result;
@JsonKey(name: "topGovernorateStudents",defaultValue: const [])
final List<TopGovernorateStudentsModel> topGovernorateStudents;
@JsonKey(name: "topAdministrationStudents",defaultValue: const [])
final List<TopAdministrationStudentsModel> topAdministrationStudents;
@JsonKey(name: "topSchoolStudents",defaultValue: const [])
final List<TopSchoolStudentsModel> topSchoolStudents;
required this.result,
required this.topGovernorateStudents,
required this.topAdministrationStudents,
required this.topSchoolStudents,

//[]
}
