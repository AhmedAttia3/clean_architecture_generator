import 'package:eitherx/eitherx.dart';
///[BaseUseCase]
///[Implementation]
abstract class BaseUseCase<RES, POS> {
RES execute({POS? request});
}
