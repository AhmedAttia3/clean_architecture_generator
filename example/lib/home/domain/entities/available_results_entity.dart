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
