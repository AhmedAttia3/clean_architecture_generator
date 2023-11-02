///[Implementation]
import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/requests/add_comment8_request.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

///[AddComment8UseCase]
///[Implementation]
@injectable
class AddComment8UseCase implements BaseUseCase<AddComment8Request,Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>>>{
final HomeRepository repository;
const AddComment8UseCase(
this.repository,
);



































@override
Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> execute({AddComment8Request? request,}) async {
return await repository.addComment8
(storyId3: request!.storyId3,content3: request!.content3,);
}



































}
