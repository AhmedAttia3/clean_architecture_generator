import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';

class AddressEntity {
final int id;
final String name;
const AddressEntity({
required this.id,
required this.name,
 });

}

