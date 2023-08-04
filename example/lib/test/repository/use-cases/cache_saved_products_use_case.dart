import 'package:eitherx/eitherx.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/test/repository/data-source/settings_remote_data_source_repository.dart';

///[CacheSavedProductsUseCase]
///[Implementation]
@injectable
class CacheSavedProductsUseCase implements BaseUseCase<Future<Either<Failure, Unit>>,double> {
final SettingsRemoteDataSourceRepository repository;
const CacheSavedProductsUseCase(
this.repository,
);

@override
Future<Either<Failure, Unit>> execute({double? request,}) async {
if(request != null){
return await repository.cacheSavedProducts
(data: request);
}
return const Right(unit);
}

}

