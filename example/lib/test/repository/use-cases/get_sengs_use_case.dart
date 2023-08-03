///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'dart:ffi';
import 'package:example/test/repository/data-source/settings_remote_data_source_repository.dart';

///[GetSengsUseCase]
///[Implementation]
@injectable
class GetSengsUseCase implements BaseUseCase<Future<Either<Failure, BaseResponse<InvalidType>>>,Void>{
final SettingsRemoteDataSourceRepository repository;
const GetSengsUseCase(
this.repository,
);

@override
Future<Either<Failure, BaseResponse<InvalidType>>> execute({Void? request,}) async {
return await repository.getSengs
();
}

}

