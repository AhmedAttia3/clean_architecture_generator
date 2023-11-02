///[Implementation]
import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/requests/add_comment4_request.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

///[AddComment4UseCase]
///[Implementation]
@injectable
class AddComment4UseCase implements BaseUseCase<AddComment4Request,Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>>>{
final HomeRepository repository;
const AddComment4UseCase(
this.repository,
);





























































@override
Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> execute({AddComment4Request? request,}) async {
return await repository.addComment4
(storyId: request!.storyId,content: request!.content,);
}





























































}
