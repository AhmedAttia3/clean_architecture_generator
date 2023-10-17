import 'package:eitherx/eitherx.dart';
///[BaseUseCase]
///[Implementation]
abstract class BaseUseCase<In, Out> {
Out execute({In? request});
}
