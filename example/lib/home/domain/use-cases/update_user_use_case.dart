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

///[UpdateUserUseCase]
///[Implementation]
@injectable
class UpdateUserUseCase implements BaseUseCase<int,Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>>>{
final HomeRepository repository;
const UpdateUserUseCase(
this.repository,
);

@override
Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> execute({int? request,}) async {
return await repository.updateUser
(firebaseToken : request!);
}

}

