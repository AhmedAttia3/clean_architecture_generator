import 'package:clean_architecture_generator/models/clean_method.dart';
import 'package:clean_architecture_generator/src/annotations.dart';

@CleanArchitecture
abstract class CleanArchitectureSetUp {
  List<CleanMethod> get methods;
}

@TDDCleanArchitecture
abstract class TDDCleanArchitectureSetUp {
  List<CleanMethod> get methods;
}
