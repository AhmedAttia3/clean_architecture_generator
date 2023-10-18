import 'package:example/home/domain/entities/available_results_entity.dart';

class GovernorateEntity {
  final int id;
  final String name;
  final bool isFavourite;
  final List<AvailableResultsEntity> availableResults;

  const GovernorateEntity({
    required this.id,
    required this.name,
    required this.isFavourite,
    required this.availableResults,
  });
}
