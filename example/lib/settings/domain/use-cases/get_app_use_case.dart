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
import 'package:example/settings/domain/requests/get_app_request.dart';

///[GetAppUseCase]
///[Implementation]
@injectable
class GetAppUseCase implements BaseUseCase<Future<Either<Failure, BaseResponse<dynamic>>>,GetAppRequest>{
final SettingsRemoteDataSourceRepository repository;
const GetAppUseCase(
this.repository,
);

@override
Future<Either<Failure, BaseResponse<dynamic>>> execute({GetAppRequest? request,}) async {
return await repository.getApp
(page: request!.page,limit: request!.limit,);
}

}

