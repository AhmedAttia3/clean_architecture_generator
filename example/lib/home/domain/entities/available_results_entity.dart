import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';

class AvailableResultsEntity {
final int id;
final String year;
final String status;
final bool isSearchableByName;
final bool isSearchableBySittingNumber;
final String term;
final int termId;
final String state;
const AvailableResultsEntity({
required this.id,
required this.year,
required this.status,
required this.isSearchableByName,
required this.isSearchableBySittingNumber,
required this.term,
required this.termId,
required this.state,
 });

}

