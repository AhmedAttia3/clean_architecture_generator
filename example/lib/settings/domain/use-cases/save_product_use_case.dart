///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/domain/repository/settings_remote_data_source_repository.dart';
import 'package:example/settings/domain/requests/save_product_request.dart';

///[SaveProductUseCase]
///[Implementation]
@injectable
class SaveProductUseCase implements BaseUseCase<Future<Either<Failure, BaseResponse<dynamic>>>,SaveProductRequest>{
final SettingsRemoteDataSourceRepository repository;
const SaveProductUseCase(
this.repository,
);

@override
Future<Either<Failure, BaseResponse<dynamic>>> execute({SaveProductRequest? request,}) async {
return await repository.saveProduct
(productId: request!.productId,type: request!.type,);
}

}

