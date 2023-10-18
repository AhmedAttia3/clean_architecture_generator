import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/use-cases/get_cache_update_user_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:request_builder/request_builder.dart';

@injectable
class GetCacheUpdateUserCubit extends Cubit<FlowState> {
  final GetCacheUpdateUserUseCase _getCacheUpdateUserUseCase;
  DeviceSettingsEntity? updateUser;

  GetCacheUpdateUserCubit(this._getCacheUpdateUserUseCase)
      : super(const ContentState());

  void execute() {
    emit(const LoadingState(type: LoadingRendererType.popup));
    final res = _getCacheUpdateUserUseCase.execute();
    res.right((data) {
      updateUser = data;
      emit(const ContentState());
    });
    res.left((failure) {
      emit(ErrorState(
        type: ErrorRendererType.toast,
        message: failure.message,
      ));
    });
  }
}
