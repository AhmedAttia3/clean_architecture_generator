import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/use-cases/get_cache_add_comment7_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:request_builder/request_builder.dart';

@injectable
class GetCacheAddComment7Cubit extends Cubit<FlowState> {
  final GetCacheAddComment7UseCase _getCacheAddComment7UseCase;
  DeviceSettingsEntity? addComment7;

  GetCacheAddComment7Cubit(this._getCacheAddComment7UseCase)
      : super(const ContentState());

  void execute() {
    emit(const LoadingState(type: LoadingRendererType.popup));
    final res = _getCacheAddComment7UseCase.execute();
    res.right((data) {
      addComment7 = data;
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
