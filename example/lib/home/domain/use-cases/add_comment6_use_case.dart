///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/requests/add_comment6_request.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';

///[AddComment6UseCase]
///[Implementation]
@injectable
class AddComment6UseCase
    implements
        BaseUseCase<AddComment6Request,
            Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>>> {
  final HomeRepository repository;

  const AddComment6UseCase(
    this.repository,
  );

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> execute({
    AddComment6Request? request,
  }) async {
    return await repository.addComment6(
      storyId: request!.storyId,
      content: request!.content,
    );
  }
}
