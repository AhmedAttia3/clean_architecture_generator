import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';

class TopSchoolStudentsEntity {
final String studentName;
final double percentage;
final String school;
const TopSchoolStudentsEntity({
required this.studentName,
required this.percentage,
required this.school,
 });

}

