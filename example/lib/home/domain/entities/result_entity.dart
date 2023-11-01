import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/domain/entities/settings_entity.dart';

class ResultEntity {
final int id;
final int sittingNumber;
final String studentName;
final String school;
final String arabic;
final String english;
final String algebra;
final String engineering;
final Null mathematics;
final String sciences;
final String studies;
final String religious;
final String art;
final String physicalEducation;
final Null firstLevel;
final Null secondLevel;
final Null englishLevel;
final String computer;
final Null french;
final Null administration;
final String total;
final double percentage;
final Null status;
final int statusNumber;
final int termId;
final String governorateName;
final SettingsEntity? settings;
const ResultEntity({
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


final List<ResultEntity> result;
final List<TopGovernorateStudentsEntity> topGovernorateStudents;
final List<TopAdministrationStudentsEntity> topAdministrationStudents;
final List<TopSchoolStudentsEntity> topSchoolStudents;
required this.result,
required this.topGovernorateStudents,
required this.topAdministrationStudents,
required this.topSchoolStudents,

//[]
}
