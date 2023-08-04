import 'package:eitherx/eitherx.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/core/states.dart';
import 'package:example/core/fold.dart';
import 'package:example/core/state_renderer.dart';
import 'package:example/settings/domain/use-cases/get_cache_settings_use_case.dart';

@injectable
class GetCacheSettingsCubit extends Cubit<FlowState> {
final GetCacheSettingsUseCase _getSettingsUseCase;
SettingsModel? settings;
GetCacheSettingsCubit(this._getSettingsUseCase) : super(ContentState());
void execute() {
emit(LoadingState(type: StateRendererType.fullScreenLoading));
final res =  _getSettingsUseCase.execute();
res.right((data) {
settings = data;
emit(ContentState());
});
res.left((failure) {
emit(ErrorState(
type: StateRendererType.toastError,
message: failure.message,
));
});
}
}
