///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'dart:ffi';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/entities/governorate_entity.dart';
import 'package:example/home/domain/entities/result_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

///[AddFavoriteUseCase]
///[Implementation]
@injectable
class AddFavoriteUseCase implements BaseUseCase<Future<Either<Failure, BaseResponse<int>>>,int>{
final HomeRepository repository;
const AddFavoriteUseCase(
this.repository,
);

@override
Future<Either<Failure, BaseResponse<int>>> execute({int? request,}) async {
return await repository.addFavorite
(countryId : request!);
}

}

