///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/test/repository/data-source/settings_remote_data_source_repository.dart';
import 'package:example/test/repository/requests/save_product_request.dart';

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

