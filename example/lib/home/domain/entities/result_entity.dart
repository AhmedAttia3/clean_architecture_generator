import 'package:example/home/domain/entities/top_administration_students_entity.dart';
import 'package:example/home/domain/entities/top_governorate_students_entity.dart';
import 'package:example/home/domain/entities/top_school_students_entity.dart';

class ResultEntity {
  final List<ResultEntity> result;
  final List<TopGovernorateStudentsEntity> topGovernorateStudents;
  final List<TopAdministrationStudentsEntity> topAdministrationStudents;
  final List<TopSchoolStudentsEntity> topSchoolStudents;

  const ResultEntity({
    required this.result,
    required this.topGovernorateStudents,
    required this.topAdministrationStudents,
    required this.topSchoolStudents,
  });
}
