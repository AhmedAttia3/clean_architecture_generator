import 'package:eitherx/eitherx.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'dart:ffi';
import 'package:example/settings/domain/repository/settings_remote_data_source_repository.dart';

///[GetCacheSavedProductsUseCase]
///[Implementation]
@injectable
class GetCacheSavedProductsUseCase implements BaseUseCase<Either<Failure, List<ProductModel>>, Void?>{
final SettingsRemoteDataSourceRepository repository;
const GetCacheSavedProductsUseCase(
this.repository,
);

@override
Either<Failure, List<ProductModel>> execute({Void? request,}) {
return repository.getCacheSavedProducts();
}

}

