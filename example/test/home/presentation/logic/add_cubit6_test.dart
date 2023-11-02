import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/presentation/logic/add_cubit6.dart';
import 'package:example/home/domain/requests/add_comment6_request.dart';
import 'package:example/home/domain/requests/add_comment7_request.dart';
import 'package:example/home/domain/requests/add_comment8_request.dart';
import 'package:example/home/domain/use-cases/add_comment6_use_case.dart';
import 'package:example/home/domain/use-cases/add_comment7_use_case.dart';
import 'package:example/home/domain/use-cases/add_comment8_use_case.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'dart:io';import 'dart:convert';import 'package:flutter/material.dart';import 'package:bloc_test/bloc_test.dart';import 'package:eitherx/eitherx.dart';import 'package:flutter_test/flutter_test.dart';import 'package:mockito/annotations.dart';import 'package:mockito/mockito.dart';import 'package:request_builder/request_builder.dart';import 'package:mwidgets/mwidgets.dart';import 'add_cubit6_test.mocks.dart';
 @GenerateNiceMocks([
   MockSpec<TextEditingController>(),
   MockSpec<GlobalKey<FormState>>(),
   MockSpec<FormState>(),
   MockSpec<AddComment6UseCase>(),
   MockSpec<AddComment7UseCase>(),
   MockSpec<AddComment8UseCase>(),
 ])
 void main() {
   late AddCubit6 cubit;
   late AddComment6UseCase addComment6UseCase;
   late AddComment7UseCase addComment7UseCase;
   late AddComment8UseCase addComment8UseCase;
   late TextEditingController content1;
   late GlobalKey<FormState> addComment6UseCaseKey;
   late FormState addComment6UseCaseFormState;
   late TextEditingController content2;
   late GlobalKey<FormState> addComment7UseCaseKey;
   late FormState addComment7UseCaseFormState;
   late TextEditingController content3;
   late GlobalKey<FormState> addComment8UseCaseKey;
   late FormState addComment8UseCaseFormState;
   late AddComment6Request addComment6Request;
   late AddComment7Request addComment7Request;
   late AddComment8Request addComment8Request;
   late BaseResponse<DeviceSettingsModel?> addComment6Response;
   late BaseResponse<DeviceSettingsModel?> addComment7Response;
   late BaseResponse<DeviceSettingsModel?> addComment8Response;
   late Failure failure;
   setUp(() async {
     content1 = MockTextEditingController();
     addComment6UseCaseKey = MockGlobalKey();
     addComment6UseCaseFormState = MockFormState();
     addComment6UseCase = MockAddComment6UseCase();
     content2 = MockTextEditingController();
     addComment7UseCaseKey = MockGlobalKey();
     addComment7UseCaseFormState = MockFormState();
     addComment7UseCase = MockAddComment7UseCase();
     content3 = MockTextEditingController();
     addComment8UseCaseKey = MockGlobalKey();
     addComment8UseCaseFormState = MockFormState();
     addComment8UseCase = MockAddComment8UseCase();
   addComment6Request = AddComment6Request(storyId1: "storyId1",content1: "content1",);
///[AddComment6]
   addComment7Request = AddComment7Request(storyId2: "storyId2",content2: "content2",);
///[AddComment7]
   addComment8Request = AddComment8Request(storyId3: "storyId3",content3: "content3",);
///[AddComment8]
addComment6Response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
addComment7Response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
addComment8Response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
     failure = Failure(1, '');
     cubit = AddCubit6(
     addComment6UseCase,
     addComment6UseCaseKey,
     addComment6Request,
     content1,
     addComment7UseCase,
     addComment7UseCaseKey,
     addComment7Request,
     content2,
     addComment8UseCase,
     addComment8UseCaseKey,
     addComment8Request,
     content3,
     );
   });
 group('AddCubit6 CUBIT', () {
///[addComment6UseCase]
     blocTest<AddCubit6, FlowState>(
       'executeAddComment6 validation error METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment6UseCaseKey.currentState).thenAnswer((realInvocation) => addComment6UseCaseFormState);
         when(addComment6UseCaseFormState.validate()).thenAnswer((realInvocation) => false);
         cubit.executeAddComment6(storyId1: "storyId1",);
       },
       expect: () => <FlowState>[],
     );

     blocTest<AddCubit6, FlowState>(
       'executeAddComment6 success true status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment6UseCaseKey.currentState).thenAnswer((realInvocation) => addComment6UseCaseFormState);
         when(addComment6UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content1.text).thenAnswer((realInvocation) => "content1");
         when(addComment6UseCase.execute(request : addComment6Request))
             .thenAnswer((realInvocation) async => Right(addComment6Response));
         cubit.executeAddComment6(storyId1: "storyId1",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         SuccessState(type: SuccessRendererType.none,message: "message",),
       ],
     );
     blocTest<AddCubit6, FlowState>(
       'executeAddComment6 success false status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment6UseCaseKey.currentState).thenAnswer((realInvocation) => addComment6UseCaseFormState);
         when(addComment6UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content1.text).thenAnswer((realInvocation) => "content1");
         when(addComment6UseCase.execute(request : addComment6Request))
                 .thenAnswer((realInvocation) async => Right(addComment6Response..success = false));
         cubit.executeAddComment6(storyId1: "storyId1",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         ErrorState(type: ErrorRendererType.toast,message: "message",),
       ],
     );

   blocTest<AddCubit6, FlowState>(
     'executeAddComment6 failure METHOD',
     build: () => cubit,
     act: (cubit) {
       when(addComment6UseCaseKey.currentState).thenAnswer((realInvocation) => addComment6UseCaseFormState);
       when(addComment6UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content1.text).thenAnswer((realInvocation) => "content1");
         when(addComment6UseCase.execute(request : addComment6Request))
           .thenAnswer((realInvocation) async => Left(failure));
       cubit.executeAddComment6(storyId1: "storyId1",);
     },
     expect: () => <FlowState>[
       const LoadingState(type: LoadingRendererType.popup),
       ErrorState(type: ErrorRendererType.toast,message: failure.message,),
     ],
   );
///[addComment7UseCase]
     blocTest<AddCubit6, FlowState>(
       'executeAddComment7 validation error METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment7UseCaseKey.currentState).thenAnswer((realInvocation) => addComment7UseCaseFormState);
         when(addComment7UseCaseFormState.validate()).thenAnswer((realInvocation) => false);
         cubit.executeAddComment7(storyId2: "storyId2",);
       },
       expect: () => <FlowState>[],
     );

     blocTest<AddCubit6, FlowState>(
       'executeAddComment7 success true status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment7UseCaseKey.currentState).thenAnswer((realInvocation) => addComment7UseCaseFormState);
         when(addComment7UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content2.text).thenAnswer((realInvocation) => "content2");
         when(addComment7UseCase.execute(request : addComment7Request))
             .thenAnswer((realInvocation) async => Right(addComment7Response));
         cubit.executeAddComment7(storyId2: "storyId2",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         SuccessState(type: SuccessRendererType.none,message: "message",),
       ],
     );
     blocTest<AddCubit6, FlowState>(
       'executeAddComment7 success false status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment7UseCaseKey.currentState).thenAnswer((realInvocation) => addComment7UseCaseFormState);
         when(addComment7UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content2.text).thenAnswer((realInvocation) => "content2");
         when(addComment7UseCase.execute(request : addComment7Request))
                 .thenAnswer((realInvocation) async => Right(addComment7Response..success = false));
         cubit.executeAddComment7(storyId2: "storyId2",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         ErrorState(type: ErrorRendererType.toast,message: "message",),
       ],
     );

   blocTest<AddCubit6, FlowState>(
     'executeAddComment7 failure METHOD',
     build: () => cubit,
     act: (cubit) {
       when(addComment7UseCaseKey.currentState).thenAnswer((realInvocation) => addComment7UseCaseFormState);
       when(addComment7UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content2.text).thenAnswer((realInvocation) => "content2");
         when(addComment7UseCase.execute(request : addComment7Request))
           .thenAnswer((realInvocation) async => Left(failure));
       cubit.executeAddComment7(storyId2: "storyId2",);
     },
     expect: () => <FlowState>[
       const LoadingState(type: LoadingRendererType.popup),
       ErrorState(type: ErrorRendererType.toast,message: failure.message,),
     ],
   );
///[addComment8UseCase]
     blocTest<AddCubit6, FlowState>(
       'executeAddComment8 validation error METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment8UseCaseKey.currentState).thenAnswer((realInvocation) => addComment8UseCaseFormState);
         when(addComment8UseCaseFormState.validate()).thenAnswer((realInvocation) => false);
         cubit.executeAddComment8(storyId3: "storyId3",);
       },
       expect: () => <FlowState>[],
     );

     blocTest<AddCubit6, FlowState>(
       'executeAddComment8 success true status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment8UseCaseKey.currentState).thenAnswer((realInvocation) => addComment8UseCaseFormState);
         when(addComment8UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content3.text).thenAnswer((realInvocation) => "content3");
         when(addComment8UseCase.execute(request : addComment8Request))
             .thenAnswer((realInvocation) async => Right(addComment8Response));
         cubit.executeAddComment8(storyId3: "storyId3",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         SuccessState(type: SuccessRendererType.none,message: "message",),
       ],
     );
     blocTest<AddCubit6, FlowState>(
       'executeAddComment8 success false status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment8UseCaseKey.currentState).thenAnswer((realInvocation) => addComment8UseCaseFormState);
         when(addComment8UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content3.text).thenAnswer((realInvocation) => "content3");
         when(addComment8UseCase.execute(request : addComment8Request))
                 .thenAnswer((realInvocation) async => Right(addComment8Response..success = false));
         cubit.executeAddComment8(storyId3: "storyId3",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         ErrorState(type: ErrorRendererType.toast,message: "message",),
       ],
     );

   blocTest<AddCubit6, FlowState>(
     'executeAddComment8 failure METHOD',
     build: () => cubit,
     act: (cubit) {
       when(addComment8UseCaseKey.currentState).thenAnswer((realInvocation) => addComment8UseCaseFormState);
       when(addComment8UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content3.text).thenAnswer((realInvocation) => "content3");
         when(addComment8UseCase.execute(request : addComment8Request))
           .thenAnswer((realInvocation) async => Left(failure));
       cubit.executeAddComment8(storyId3: "storyId3",);
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
