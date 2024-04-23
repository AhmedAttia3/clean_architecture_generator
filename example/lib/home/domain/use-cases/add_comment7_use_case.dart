///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/requests/add_comment7_request.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';

///[AddComment7UseCase]
///[Implementation]
@injectable
class AddComment7UseCase
    implements
        BaseUseCase<AddComment7Request,
            Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>>> {
  final HomeRepository repository;

  const AddComment7UseCase(
    this.repository,
  );

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> execute({
    AddComment7Request? request,
  }) async {
    return await repository.addComment7(
      storyId2: request!.storyId2,
      content2: request!.content2,
    );
  }
}
