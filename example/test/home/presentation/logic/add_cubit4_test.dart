import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/presentation/logic/add_cubit4.dart';
import 'package:example/home/domain/requests/add_comment4_request.dart';
import 'package:example/home/domain/use-cases/add_comment4_use_case.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'dart:io';import 'dart:convert';import 'package:flutter/material.dart';import 'package:bloc_test/bloc_test.dart';import 'package:eitherx/eitherx.dart';import 'package:flutter_test/flutter_test.dart';import 'package:mockito/annotations.dart';import 'package:mockito/mockito.dart';import 'package:request_builder/request_builder.dart';import 'package:mwidgets/mwidgets.dart';import 'add_cubit4_test.mocks.dart';
 @GenerateNiceMocks([
   MockSpec<TextEditingController>(),
   MockSpec<GlobalKey<FormState>>(),
   MockSpec<FormState>(),
   MockSpec<AddComment4UseCase>(),
 ])
 void main() {
   late AddCubit4 cubit;
   late AddComment4UseCase addComment4UseCase;
   late TextEditingController content;
   late GlobalKey<FormState> addComment4UseCaseKey;
   late FormState addComment4UseCaseFormState;
   late AddComment4Request addComment4Request;
   late BaseResponse<DeviceSettingsModel?> addComment4Response;
   late Failure failure;
   setUp(() async {
     content = MockTextEditingController();
     addComment4UseCaseKey = MockGlobalKey();
     addComment4UseCaseFormState = MockFormState();
     addComment4UseCase = MockAddComment4UseCase();
   addComment4Request = AddComment4Request(storyId: "storyId",content: "content",);
///[AddComment4]
addComment4Response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
     failure = Failure(1, '');
     cubit = AddCubit4(
     addComment4UseCase,
     addComment4UseCaseKey,
     addComment4Request,
     content,
     );
   });
 group('AddCubit4 CUBIT', () {
///[addComment4UseCase]
     blocTest<AddCubit4, FlowState>(
       'executeAddComment4 validation error METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment4UseCaseKey.currentState).thenAnswer((realInvocation) => addComment4UseCaseFormState);
         when(addComment4UseCaseFormState.validate()).thenAnswer((realInvocation) => false);
         cubit.executeAddComment4(storyId: "storyId",);
       },
       expect: () => <FlowState>[],
     );

     blocTest<AddCubit4, FlowState>(
       'executeAddComment4 success true status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment4UseCaseKey.currentState).thenAnswer((realInvocation) => addComment4UseCaseFormState);
         when(addComment4UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content.text).thenAnswer((realInvocation) => "content");
         when(addComment4UseCase.execute(request : addComment4Request))
             .thenAnswer((realInvocation) async => Right(addComment4Response));
         cubit.executeAddComment4(storyId: "storyId",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         SuccessState(type: SuccessRendererType.none,message: "message",),
       ],
     );
     blocTest<AddCubit4, FlowState>(
       'executeAddComment4 success false status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment4UseCaseKey.currentState).thenAnswer((realInvocation) => addComment4UseCaseFormState);
         when(addComment4UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content.text).thenAnswer((realInvocation) => "content");
         when(addComment4UseCase.execute(request : addComment4Request))
                 .thenAnswer((realInvocation) async => Right(addComment4Response..success = false));
         cubit.executeAddComment4(storyId: "storyId",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         ErrorState(type: ErrorRendererType.toast,message: "message",),
       ],
     );

   blocTest<AddCubit4, FlowState>(
     'executeAddComment4 failure METHOD',
     build: () => cubit,
     act: (cubit) {
       when(addComment4UseCaseKey.currentState).thenAnswer((realInvocation) => addComment4UseCaseFormState);
       when(addComment4UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content.text).thenAnswer((realInvocation) => "content");
         when(addComment4UseCase.execute(request : addComment4Request))
           .thenAnswer((realInvocation) async => Left(failure));
       cubit.executeAddComment4(storyId: "storyId",);
     },
     expect: () => <FlowState>[
       const LoadingState(type: LoadingRendererType.popup),
       ErrorState(type: ErrorRendererType.toast,message: failure.message,),
     ],
   );
   });
 }
///[FromJson]
Map<String, dynamic> json(String path) {
 return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
