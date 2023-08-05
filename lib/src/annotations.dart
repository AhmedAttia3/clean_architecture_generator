// ignore_for_file: constant_identifier_names

abstract class CleanAnnotation {}

class ArchitectureAnnotation implements CleanAnnotation {
  const ArchitectureAnnotation();
}

class ArchitectureTDDAnnotation
    implements CleanAnnotation, ArchitectureAnnotation {
  const ArchitectureTDDAnnotation();
}

const GenerateArchitecture = ArchitectureAnnotation();

const GenerateTDDArchitecture = ArchitectureTDDAnnotation();
