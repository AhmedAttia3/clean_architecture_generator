import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/use-cases/get_cache_add_comment6_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:request_builder/request_builder.dart';

@injectable
class GetCacheAddComment6Cubit extends Cubit<FlowState> {
  final GetCacheAddComment6UseCase _getCacheAddComment6UseCase;
  DeviceSettingsEntity? addComment6;

  GetCacheAddComment6Cubit(this._getCacheAddComment6UseCase)
      : super(const ContentState());

  void execute() {
    emit(const LoadingState(type: LoadingRendererType.popup));
    final res = _getCacheAddComment6UseCase.execute();
    res.right((data) {
      addComment6 = data;
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
