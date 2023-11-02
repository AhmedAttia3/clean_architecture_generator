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
import 'package:example/home/domain/requests/add_comment5_request.dart';
import 'package:example/home/domain/use-cases/get_cache_add_comment5_use_case.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

@injectable
class GetCacheAddCubit5Cubit extends Cubit<FlowState> {
final GetCacheAddComment5UseCase _getCacheAddComment5UseCase;
DeviceSettingsEntity? addComment5;
GetCacheAddCubit5Cubit(this._getCacheAddComment5UseCase) : super(const ContentState());
void execute() {
emit(const LoadingState(type: LoadingRendererType.popup));
final res =  _getCacheAddComment5UseCase.execute();
res.right((data) {
addComment5 = data;
emit(const ContentState());
});
res.left((failure) {
emit(ErrorState(type: ErrorRendererType.toast,message: failure.message,));
});
}
}
