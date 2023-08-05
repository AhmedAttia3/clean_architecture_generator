// ignore_for_file: constant_identifier_names

abstract class CleanAnnotation {}

class ArchitectureAnnotation implements CleanAnnotation {
  const ArchitectureAnnotation();
}

class ArchitectureTDDAnnotation implements ArchitectureAnnotation {
  const ArchitectureTDDAnnotation();
}

const CleanArchitecture = ArchitectureAnnotation();

const TDDCleanArchitecture = ArchitectureTDDAnnotation();
