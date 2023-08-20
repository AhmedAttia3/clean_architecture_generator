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
import 'package:example/settings/domain/use-cases/register_use_case.dart';
import 'package:example/settings/domain/requests/register_request.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/address_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';

///[RegisterCubit]
///[Implementation]
@injectable
class RegisterCubit extends Cubit<FlowState> {
final RegisterUseCase _registerUseCase;
final RegisterRequest request;
final GlobalKey<FormState> formKey;
final TextEditingController fullName;
final TextEditingController phone;
final TextEditingController email;
final TextEditingController password;
RegisterCubit(this._registerUseCase,
this.formKey,
this.request,
this.fullName,
this.phone,
this.email,
this.password,
) : super(ContentState());

UserEntity? register;
String id = "";

Future<void> execute() async {
if (formKey.currentState!.validate()) {
request.fullName =
fullName.text;
request.phone =
phone.text;
request.email =
email.text;
request.password =
password.text;
request.id = id;
emit(LoadingState(type: StateRendererType.popUpLoading));
final res = await _registerUseCase.execute(
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
register = data.data!;
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
void setId(String value){
id = value;
}
}
