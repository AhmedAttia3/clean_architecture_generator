import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/presentation/logic/add_cubit.dart';
import 'package:example/home/domain/requests/add_comment_request.dart';
import 'package:example/home/domain/requests/add_comment2_request.dart';
import 'package:example/home/domain/use-cases/add_comment_use_case.dart';
import 'package:example/home/domain/use-cases/add_comment2_use_case.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'dart:io';import 'dart:convert';import 'package:flutter/material.dart';import 'package:bloc_test/bloc_test.dart';import 'package:eitherx/eitherx.dart';import 'package:flutter_test/flutter_test.dart';import 'package:mockito/annotations.dart';import 'package:mockito/mockito.dart';import 'package:request_builder/request_builder.dart';import 'package:mwidgets/mwidgets.dart';import 'add_cubit_test.mocks.dart';
 @GenerateNiceMocks([
   MockSpec<TextEditingController>(),
   MockSpec<GlobalKey<FormState>>(),
   MockSpec<FormState>(),
   MockSpec<AddCommentUseCase>(),
   MockSpec<AddComment2UseCase>(),
 ])
 void main() {
   late AddCubit cubit;
   late AddCommentUseCase addCommentUseCase;
   late AddComment2UseCase addComment2UseCase;
   late TextEditingController content1;
   late GlobalKey<FormState> addCommentUseCaseKey;
   late FormState addCommentUseCaseFormState;
   late TextEditingController content2;
   late GlobalKey<FormState> addComment2UseCaseKey;
   late FormState addComment2UseCaseFormState;
   late AddCommentRequest addCommentRequest;
   late AddComment2Request addComment2Request;
   late BaseResponse<DeviceSettingsModel?> addCommentResponse;
   late BaseResponse<DeviceSettingsModel?> addComment2Response;
   late Failure failure;
   setUp(() async {
     content1 = MockTextEditingController();
     addCommentUseCaseKey = MockGlobalKey();
     addCommentUseCaseFormState = MockFormState();
     addCommentUseCase = MockAddCommentUseCase();
     content2 = MockTextEditingController();
     addComment2UseCaseKey = MockGlobalKey();
     addComment2UseCaseFormState = MockFormState();
     addComment2UseCase = MockAddComment2UseCase();
   addCommentRequest = AddCommentRequest(storyId1: "storyId1",content1: "content1",);
///[AddComment]
   addComment2Request = AddComment2Request(storyId2: "storyId2",content2: "content2",);
///[AddComment2]
addCommentResponse = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
addComment2Response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
     failure = Failure(1, '');
     cubit = AddCubit(
     addCommentUseCase,
     addCommentUseCaseKey,
     addCommentRequest,
     content1,
     addComment2UseCase,
     addComment2UseCaseKey,
     addComment2Request,
     content2,
     );
   });
 group('AddCubit CUBIT', () {
///[addCommentUseCase]
     blocTest<AddCubit, FlowState>(
       'executeAddComment validation error METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addCommentUseCaseKey.currentState).thenAnswer((realInvocation) => addCommentUseCaseFormState);
         when(addCommentUseCaseFormState.validate()).thenAnswer((realInvocation) => false);
         cubit.executeAddComment(storyId1: "storyId1",);
       },
       expect: () => <FlowState>[],
     );

     blocTest<AddCubit, FlowState>(
       'executeAddComment success true status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addCommentUseCaseKey.currentState).thenAnswer((realInvocation) => addCommentUseCaseFormState);
         when(addCommentUseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content1.text).thenAnswer((realInvocation) => "content1");
         when(addCommentUseCase.execute(request : addCommentRequest))
             .thenAnswer((realInvocation) async => Right(addCommentResponse));
         cubit.executeAddComment(storyId1: "storyId1",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         SuccessState(type: SuccessRendererType.none,message: "message",),
       ],
     );
     blocTest<AddCubit, FlowState>(
       'executeAddComment success false status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addCommentUseCaseKey.currentState).thenAnswer((realInvocation) => addCommentUseCaseFormState);
         when(addCommentUseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content1.text).thenAnswer((realInvocation) => "content1");
         when(addCommentUseCase.execute(request : addCommentRequest))
                 .thenAnswer((realInvocation) async => Right(addCommentResponse..success = false));
         cubit.executeAddComment(storyId1: "storyId1",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         ErrorState(type: ErrorRendererType.toast,message: "message",),
       ],
     );

   blocTest<AddCubit, FlowState>(
     'executeAddComment failure METHOD',
     build: () => cubit,
     act: (cubit) {
       when(addCommentUseCaseKey.currentState).thenAnswer((realInvocation) => addCommentUseCaseFormState);
       when(addCommentUseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content1.text).thenAnswer((realInvocation) => "content1");
         when(addCommentUseCase.execute(request : addCommentRequest))
           .thenAnswer((realInvocation) async => Left(failure));
       cubit.executeAddComment(storyId1: "storyId1",);
     },
     expect: () => <FlowState>[
       const LoadingState(type: LoadingRendererType.popup),
       ErrorState(type: ErrorRendererType.toast,message: failure.message,),
     ],
   );
///[addComment2UseCase]
     blocTest<AddCubit, FlowState>(
       'executeAddComment2 validation error METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment2UseCaseKey.currentState).thenAnswer((realInvocation) => addComment2UseCaseFormState);
         when(addComment2UseCaseFormState.validate()).thenAnswer((realInvocation) => false);
         cubit.executeAddComment2(storyId2: "storyId2",);
       },
       expect: () => <FlowState>[],
     );

     blocTest<AddCubit, FlowState>(
       'executeAddComment2 success true status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment2UseCaseKey.currentState).thenAnswer((realInvocation) => addComment2UseCaseFormState);
         when(addComment2UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content2.text).thenAnswer((realInvocation) => "content2");
         when(addComment2UseCase.execute(request : addComment2Request))
             .thenAnswer((realInvocation) async => Right(addComment2Response));
         cubit.executeAddComment2(storyId2: "storyId2",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         SuccessState(type: SuccessRendererType.none,message: "message",),
       ],
     );
     blocTest<AddCubit, FlowState>(
       'executeAddComment2 success false status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment2UseCaseKey.currentState).thenAnswer((realInvocation) => addComment2UseCaseFormState);
         when(addComment2UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content2.text).thenAnswer((realInvocation) => "content2");
         when(addComment2UseCase.execute(request : addComment2Request))
                 .thenAnswer((realInvocation) async => Right(addComment2Response..success = false));
         cubit.executeAddComment2(storyId2: "storyId2",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         ErrorState(type: ErrorRendererType.toast,message: "message",),
       ],
     );

   blocTest<AddCubit, FlowState>(
     'executeAddComment2 failure METHOD',
     build: () => cubit,
     act: (cubit) {
       when(addComment2UseCaseKey.currentState).thenAnswer((realInvocation) => addComment2UseCaseFormState);
       when(addComment2UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content2.text).thenAnswer((realInvocation) => "content2");
         when(addComment2UseCase.execute(request : addComment2Request))
           .thenAnswer((realInvocation) async => Left(failure));
       cubit.executeAddComment2(storyId2: "storyId2",);
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
