///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/core/failure.dart';
import 'package:example/settings/domain/repository/settings_remote_data_source_repository.dart';
import 'package:example/settings/domain/requests/get_saved_products_request.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:injectable/injectable.dart';

///[GetSavedProductsUseCase]
///[Implementation]
@injectable
class GetSavedProductsUseCase
    implements
        BaseUseCase<Future<Either<Failure, InvalidType>>,
            GetSavedProductsRequest> {
  final SettingsRemoteDataSourceRepository repository;

  const GetSavedProductsUseCase(
    this.repository,
  );

  @override
  Future<Either<Failure, InvalidType>> execute({
    GetSavedProductsRequest? request,
  }) async {
    return await repository.getSavedProducts(
      page: request!.page,
      limit: request!.limit,
    );
  }
}
