///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
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
class GetGovernoratesUseCase implements BaseUseCase<Future<Either<Failure, BaseResponse<List<GovernorateEntity>?>>>,Void>{
final HomeRepository repository;
const GetGovernoratesUseCase(
this.repository,
);

@override
Future<Either<Failure, BaseResponse<List<GovernorateEntity>?>>> execute({Void? request,}) async {
return await repository.getGovernorates
();
}

}

