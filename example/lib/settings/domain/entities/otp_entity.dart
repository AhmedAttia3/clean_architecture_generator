import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';

class OtpEntity {
final int id;
final int code;
const OtpEntity({
required this.id,
required this.code,
 });

}

