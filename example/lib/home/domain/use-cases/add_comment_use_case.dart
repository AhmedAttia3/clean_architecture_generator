///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/requests/add_comment_request.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';

///[AddCommentUseCase]
///[Implementation]
@injectable
class AddCommentUseCase
    implements
        BaseUseCase<AddCommentRequest,
            Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>>> {
  final HomeRepository repository;

  const AddCommentUseCase(
    this.repository,
  );

  @override
  Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> execute({
    AddCommentRequest? request,
  }) async {
    return await repository.addComment(
      storyId: request!.storyId,
      content: request!.content,
    );
  }
}
