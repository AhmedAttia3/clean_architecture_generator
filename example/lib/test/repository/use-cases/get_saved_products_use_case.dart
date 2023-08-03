///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/test/repository/data-source/settings_remote_data_source_repository.dart';
import 'package:example/test/repository/requests/get_saved_products_request.dart';

///[GetSavedProductsUseCase]
///[Implementation]
@injectable
class GetSavedProductsUseCase implements BaseUseCase<Future<Either<Failure, double>>,GetSavedProductsRequest>{
final SettingsRemoteDataSourceRepository repository;
const GetSavedProductsUseCase(
this.repository,
);

@override
Future<Either<Failure, double>> execute({GetSavedProductsRequest? request,}) async {
return await repository.getSavedProducts
(page: request!.page,limit: request!.limit,);
}

}

