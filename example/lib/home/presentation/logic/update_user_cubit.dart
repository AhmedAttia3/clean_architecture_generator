import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/core/states.dart';
import 'package:example/core/fold.dart';
import 'package:example/core/state_renderer.dart';
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
) : super(ContentState());

DeviceSettingsEntity? updateUser;


Future<void> execute({required int firebaseToken, }) async {
emit(LoadingState(type: StateRendererType.popUpLoading));
final res = await _updateUserUseCase.execute(
request : firebaseToken,
);
res.left((failure) {
emit(ErrorState(
type: StateRendererType.toastError,
message: failure.message,
));
});
res.right((data) {
if (data.success) {
if(data.data != null){
updateUser = data.data!;
}
emit(SuccessState(
message: data.message,
type: StateRendererType.contentState,
));
} else {
emit(ErrorState(
message: data.message,
type: StateRendererType.toastError,
));
}
});
}
}
