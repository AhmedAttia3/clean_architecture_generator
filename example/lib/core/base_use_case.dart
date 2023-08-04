///[BaseUseCase]
///[Implementation]
import 'package:eitherx/eitherx.dart';

abstract class BaseUseCase<RES, POS> {
  RES execute({POS? request});
}
