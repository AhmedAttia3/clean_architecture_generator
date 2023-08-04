///[Implementation]
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

///[GetAAUseCase]
///[Implementation]
@injectable
class GetAAUseCase implements BaseUseCase<Future<Either<Failure, BaseResponse<int>>>,Void>{
final SettingsRemoteDataSourceRepository repository;
const GetAAUseCase(
this.repository,
);

@override
Future<Either<Failure, BaseResponse<int>>> execute({Void? request,}) async {
return await repository.getAA
();
}

}

