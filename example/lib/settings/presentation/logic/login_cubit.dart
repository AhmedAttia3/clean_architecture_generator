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
import 'package:example/settings/domain/use-cases/login_use_case.dart';
import 'package:example/settings/domain/requests/login_request.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/address_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';

///[LoginCubit]
///[Implementation]
@injectable
class LoginCubit extends Cubit<FlowState> {
final LoginUseCase _loginUseCase;
final LoginRequest request;
final GlobalKey<FormState> formKey;
final TextEditingController email;
final TextEditingController password;
LoginCubit(this._loginUseCase,
this.formKey,
this.request,
this.email,
this.password,
) : super(ContentState());

UserEntity? login;


Future<void> execute() async {
if (formKey.currentState!.validate()) {
request.email =
email.text;
request.password =
password.text;
emit(LoadingState(type: StateRendererType.popUpLoading));
final res = await _loginUseCase.execute(
request : request,
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
login = data.data!;
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
}
