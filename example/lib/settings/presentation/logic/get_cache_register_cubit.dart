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
import 'package:example/settings/domain/requests/register_request.dart';
import 'package:example/settings/domain/use-cases/get_cache_register_use_case.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/address_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';

@injectable
class GetCacheRegisterCubit extends Cubit<FlowState> {
final GetCacheRegisterUseCase _getCacheRegisterUseCase;
UserEntity? register;
GetCacheRegisterCubit(this._getCacheRegisterUseCase) : super(ContentState());
void execute() {
emit(LoadingState(type: StateRendererType.fullScreenLoading));
final res =  _getCacheRegisterUseCase.execute();
res.right((data) {
register = data;
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
