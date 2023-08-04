import 'package:eitherx/eitherx.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/settings/domain/repository/settings_remote_data_source_repository.dart';

///[CacheSavedProductsUseCase]
///[Implementation]
@injectable
class CacheSavedProductsUseCase implements BaseUseCase<Future<Either<Failure, Unit>>,List<ProductModel>> {
final SettingsRemoteDataSourceRepository repository;
const CacheSavedProductsUseCase(
this.repository,
);

@override
Future<Either<Failure, Unit>> execute({List<ProductModel>? request,}) async {
if(request != null){
return await repository.cacheSavedProducts
(data: request);
}
return const Right(unit);
}

}
