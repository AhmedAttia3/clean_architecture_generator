import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_builder/request_builder.dart';
import 'package:example/home/domain/use-cases/get_cache_update_user2_use_case.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

@injectable
class GetCacheUpdateUser2Cubit extends Cubit<FlowState> {
final GetCacheUpdateUser2UseCase _getCacheUpdateUser2UseCase;
DeviceSettingsEntity? updateUser2;
GetCacheUpdateUser2Cubit(this._getCacheUpdateUser2UseCase) : super(const ContentState());
void execute() {
emit(const LoadingState(type: LoadingRendererType.popup));
final res =  _getCacheUpdateUser2UseCase.execute();
res.right((data) {
updateUser2 = data;
emit(const ContentState());
});
res.left((failure) {
emit(ErrorState(type: ErrorRendererType.toast,message: failure.message,));
});
}
}
