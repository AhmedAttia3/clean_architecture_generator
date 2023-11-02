///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/requests/add_comment2_request.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';

///[AddComment2UseCase]
///[Implementation]
@injectable
class AddComment2UseCase
    implements
        BaseUseCase<AddComment2Request,
            Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>>> {
  final HomeRepository repository;

  const AddComment2UseCase(
    this.repository,
  );

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> execute({
    AddComment2Request? request,
  }) async {
    return await repository.addComment2(
      storyId: request!.storyId,
      content: request!.content,
    );
  }
}
