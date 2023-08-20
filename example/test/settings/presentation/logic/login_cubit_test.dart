import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/presentation/logic/login_cubit.dart';
import 'package:example/settings/domain/use-cases/login_use_case.dart';
import 'package:example/settings/domain/requests/login_request.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/state_renderer.dart';
import 'package:example/core/states.dart';
import 'package:example/core/failure.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'dart:io';import 'dart:convert';import 'package:flutter/material.dart';import 'package:bloc_test/bloc_test.dart';import 'package:eitherx/eitherx.dart';import 'package:flutter_test/flutter_test.dart';import 'package:mockito/annotations.dart';import 'package:mockito/mockito.dart';import 'login_cubit_test.mocks.dart';
 @GenerateNiceMocks([
   MockSpec<TextEditingController>(),
   MockSpec<GlobalKey<FormState>>(),
   MockSpec<FormState>(),
   MockSpec<LoginUseCase>(),
 ])
 void main() {
   late LoginCubit cubit;
   late LoginUseCase loginUseCase;
   late TextEditingController email;
   late TextEditingController password;
   late GlobalKey<FormState> key;
   late FormState formState;
   late LoginRequest request;
   late BaseResponse<UserModel?> response;
   late Failure failure;
   setUp(() async {
     email = MockTextEditingController();
     password = MockTextEditingController();
     key = MockGlobalKey();
     formState = MockFormState();
     loginUseCase = MockLoginUseCase();
     request = LoginRequest();
///[Login]
response = BaseResponse<UserModel?>(
message: 'message',
success: true,
data: UserModel.fromJson(json('expected_user_model')),);
     failure = Failure(1, '');
     cubit = LoginCubit(
     loginUseCase,
     key,
     request,
     email,
     password,
     );
   });
 group('LoginCubit CUBIT', () {
     blocTest<LoginCubit, FlowState>(
       'login validation error METHOD',
       build: () => cubit,
       act: (cubit) {
         when(key.currentState).thenAnswer((realInvocation) => formState);
         when(formState.validate()).thenAnswer((realInvocation) => false);
         cubit.execute();
       },
       expect: () => <FlowState>[],
     );

     blocTest<LoginCubit, FlowState>(
       'login success true status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(key.currentState).thenAnswer((realInvocation) => formState);
         when(formState.validate()).thenAnswer((realInvocation) => true);
         when(email.text).thenAnswer((realInvocation) => "email");
         when(password.text).thenAnswer((realInvocation) => "password");
         when(loginUseCase.execute(request : request))
             .thenAnswer((realInvocation) async => Right(response));
         cubit.execute();
       },
       expect: () => <FlowState>[
         LoadingState(type: StateRendererType.popUpLoading),
         SuccessState(message: 'message', type: StateRendererType.contentState)
       ],
     );
     blocTest<LoginCubit, FlowState>(
       'login success false status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(key.currentState).thenAnswer((realInvocation) => formState);
         when(formState.validate()).thenAnswer((realInvocation) => true);
         when(email.text).thenAnswer((realInvocation) => "email");
         when(password.text).thenAnswer((realInvocation) => "password");
         when(loginUseCase.execute(request : request))
                 .thenAnswer((realInvocation) async => Right(response..success = false));
         cubit.execute();
       },
       expect: () => <FlowState>[
         LoadingState(type: StateRendererType.popUpLoading),
         ErrorState(type: StateRendererType.toastError, message: 'message')
       ],
     );

   blocTest<LoginCubit, FlowState>(
     'login failure METHOD',
     build: () => cubit,
     act: (cubit) {
       when(key.currentState).thenAnswer((realInvocation) => formState);
       when(formState.validate()).thenAnswer((realInvocation) => true);
         when(email.text).thenAnswer((realInvocation) => "email");
         when(password.text).thenAnswer((realInvocation) => "password");
         when(loginUseCase.execute(request : request))
           .thenAnswer((realInvocation) async => Left(failure));
       cubit.execute();
     },
     expect: () => <FlowState>[
       LoadingState(type: StateRendererType.popUpLoading),
       ErrorState(type: StateRendererType.toastError, message: failure.message)
     ],
   );
   });
 }
///[FromJson]
Map<String, dynamic> json(String path) {
 return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
