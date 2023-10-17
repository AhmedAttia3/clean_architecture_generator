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
import 'package:example/home/domain/use-cases/update_user_use_case.dart';
import 'package:example/home/domain/entities/governorate_entity.dart';
import 'package:example/home/domain/entities/result_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

///[UpdateUserCubit]
///[Implementation]
@injectable
class UpdateUserCubit extends Cubit<FlowState> {
final UpdateUserUseCase _updateUserUseCase;
UpdateUserCubit(this._updateUserUseCase,
) : super(const ContentState());

DeviceSettingsEntity? updateUser;


Future<void> execute({required int  firebaseToken, }) async {
emit(const LoadingState(type: LoadingRendererType.popup));
final res = await _updateUserUseCase.execute(
request : firebaseToken,
);
res.left((failure) {
emit(ErrorState(type: ErrorRendererType.toast,message: failure.message,));
});
res.right((data) {
if (data.success) {
if(data.data != null){
updateUser = data.data!;
}
emit(SuccessState(type: SuccessRendererType.content,message: data.message,));
} else {
emit(ErrorState(type: ErrorRendererType.toast,message: data.message,));
}
});
}
}
