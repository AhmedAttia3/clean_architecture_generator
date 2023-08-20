import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/presentation/logic/register_cubit.dart';
import 'package:example/settings/domain/use-cases/register_use_case.dart';
import 'package:example/settings/domain/requests/register_request.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/state_renderer.dart';
import 'package:example/core/states.dart';
import 'package:example/core/failure.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'dart:io';import 'dart:convert';import 'package:flutter/material.dart';import 'package:bloc_test/bloc_test.dart';import 'package:eitherx/eitherx.dart';import 'package:flutter_test/flutter_test.dart';import 'package:mockito/annotations.dart';import 'package:mockito/mockito.dart';import 'register_cubit_test.mocks.dart';
 @GenerateNiceMocks([
   MockSpec<TextEditingController>(),
   MockSpec<GlobalKey<FormState>>(),
   MockSpec<FormState>(),
   MockSpec<RegisterUseCase>(),
 ])
 void main() {
   late RegisterCubit cubit;
   late RegisterUseCase registerUseCase;
   late TextEditingController fullName;
   late TextEditingController phone;
   late TextEditingController email;
   late TextEditingController password;
   late GlobalKey<FormState> key;
   late FormState formState;
   late RegisterRequest request;
   late BaseResponse<UserModel?> response;
   late Failure failure;
   setUp(() async {
     fullName = MockTextEditingController();
     phone = MockTextEditingController();
     email = MockTextEditingController();
     password = MockTextEditingController();
     key = MockGlobalKey();
     formState = MockFormState();
     registerUseCase = MockRegisterUseCase();
     request = RegisterRequest();
///[Register]
response = BaseResponse<UserModel?>(
message: 'message',
success: true,
data: UserModel.fromJson(json('expected_user_model')),);
     failure = Failure(1, '');
     cubit = RegisterCubit(
     registerUseCase,
     key,
     request,
     fullName,
     phone,
     email,
     password,
     );
   });
 group('RegisterCubit CUBIT', () {
     blocTest<RegisterCubit, FlowState>(
       'register validation error METHOD',
       build: () => cubit,
       act: (cubit) {
         when(key.currentState).thenAnswer((realInvocation) => formState);
         when(formState.validate()).thenAnswer((realInvocation) => false);
         cubit.execute();
       },
       expect: () => <FlowState>[],
     );

     blocTest<RegisterCubit, FlowState>(
       'register success true status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(key.currentState).thenAnswer((realInvocation) => formState);
         when(formState.validate()).thenAnswer((realInvocation) => true);
         when(fullName.text).thenAnswer((realInvocation) => "fullName");
         when(phone.text).thenAnswer((realInvocation) => "phone");
         when(email.text).thenAnswer((realInvocation) => "email");
         when(password.text).thenAnswer((realInvocation) => "password");
         when(registerUseCase.execute(request : request))
             .thenAnswer((realInvocation) async => Right(response));
         cubit.setId("id");
         cubit.execute();
       },
       expect: () => <FlowState>[
         LoadingState(type: StateRendererType.popUpLoading),
         SuccessState(message: 'message', type: StateRendererType.contentState)
       ],
     );
     blocTest<RegisterCubit, FlowState>(
       'register success false status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(key.currentState).thenAnswer((realInvocation) => formState);
         when(formState.validate()).thenAnswer((realInvocation) => true);
         when(fullName.text).thenAnswer((realInvocation) => "fullName");
         when(phone.text).thenAnswer((realInvocation) => "phone");
         when(email.text).thenAnswer((realInvocation) => "email");
         when(password.text).thenAnswer((realInvocation) => "password");
         when(registerUseCase.execute(request : request))
                 .thenAnswer((realInvocation) async => Right(response..success = false));
         cubit.setId("id");
         cubit.execute();
       },
       expect: () => <FlowState>[
         LoadingState(type: StateRendererType.popUpLoading),
         ErrorState(type: StateRendererType.toastError, message: 'message')
       ],
     );

   blocTest<RegisterCubit, FlowState>(
     'register failure METHOD',
     build: () => cubit,
     act: (cubit) {
       when(key.currentState).thenAnswer((realInvocation) => formState);
       when(formState.validate()).thenAnswer((realInvocation) => true);
         when(fullName.text).thenAnswer((realInvocation) => "fullName");
         when(phone.text).thenAnswer((realInvocation) => "phone");
         when(email.text).thenAnswer((realInvocation) => "email");
         when(password.text).thenAnswer((realInvocation) => "password");
         when(registerUseCase.execute(request : request))
           .thenAnswer((realInvocation) async => Left(failure));
         cubit.setId("id");
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
