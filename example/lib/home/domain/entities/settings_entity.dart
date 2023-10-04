import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/domain/entities/governorate_entity.dart';

class SettingsEntity {
final int id;
final String year;
final String status;
final bool isSearchableByName;
final bool isSearchableBySittingNumber;
final String term;
final int termId;
final String state;
final GovernorateEntity? governorate;
const SettingsEntity({
required this.id,
required this.year,
required this.status,
required this.isSearchableByName,
required this.isSearchableBySittingNumber,
required this.term,
required this.termId,
required this.state,
required this.governorate,
 });

}

