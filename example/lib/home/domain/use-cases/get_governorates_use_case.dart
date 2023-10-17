///[Implementation]
import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'dart:ffi';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/entities/governorate_entity.dart';
import 'package:example/home/domain/entities/result_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

///[GetGovernoratesUseCase]
///[Implementation]
@injectable
class GetGovernoratesUseCase implements BaseUseCase<NoParams,Future<Either<Failure, BaseResponse<List<GovernorateEntity>?>>>>{
final HomeRepository repository;
const GetGovernoratesUseCase(
this.repository,
);

@override
Future<Either<Failure, BaseResponse<List<GovernorateEntity>?>>> execute({NoParams? request,}) async {
return await repository.getGovernorates
();
}

}

