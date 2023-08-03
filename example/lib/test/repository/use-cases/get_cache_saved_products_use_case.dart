import 'package:eitherx/eitherx.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/test/repository/data-source/settings_remote_data_source_repository.dart';

///[GetCacheSavedProductsUseCase]
///[Implementation]
@injectable
class GetCacheSavedProductsUseCase implements BaseUseCase<Either<Failure, double>, Void?>{
final SettingsRemoteDataSourceRepository repository;
const GetCacheSavedProductsUseCase(
this.repository,
);

@override
Either<Failure, double> execute({Void? request,}) {
return repository.getGetSavedProducts();
}

}

