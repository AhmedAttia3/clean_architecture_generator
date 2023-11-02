import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/presentation/logic/add_cubit3.dart';
import 'package:example/home/domain/requests/add_comment3_request.dart';
import 'package:example/home/domain/use-cases/add_comment3_use_case.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'dart:io';import 'dart:convert';import 'package:flutter/material.dart';import 'package:bloc_test/bloc_test.dart';import 'package:eitherx/eitherx.dart';import 'package:flutter_test/flutter_test.dart';import 'package:mockito/annotations.dart';import 'package:mockito/mockito.dart';import 'package:request_builder/request_builder.dart';import 'package:mwidgets/mwidgets.dart';import 'add_cubit3_test.mocks.dart';
 @GenerateNiceMocks([
   MockSpec<TextEditingController>(),
   MockSpec<GlobalKey<FormState>>(),
   MockSpec<FormState>(),
   MockSpec<AddComment3UseCase>(),
 ])
 void main() {
   late AddCubit3 cubit;
   late AddComment3UseCase addComment3UseCase;
   late TextEditingController content;
   late GlobalKey<FormState> addComment3UseCaseKey;
   late FormState addComment3UseCaseFormState;
   late AddComment3Request addComment3Request;
   late BaseResponse<DeviceSettingsModel?> addComment3Response;
   late Failure failure;
   setUp(() async {
     content = MockTextEditingController();
     addComment3UseCaseKey = MockGlobalKey();
     addComment3UseCaseFormState = MockFormState();
     addComment3UseCase = MockAddComment3UseCase();
   addComment3Request = AddComment3Request(storyId: "storyId",content: "content",);
///[AddComment3]
addComment3Response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
     failure = Failure(1, '');
     cubit = AddCubit3(
     addComment3UseCase,
     addComment3UseCaseKey,
     addComment3Request,
     content,
     );
   });
 group('AddCubit3 CUBIT', () {
///[addComment3UseCase]
     blocTest<AddCubit3, FlowState>(
       'executeAddComment3 validation error METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment3UseCaseKey.currentState).thenAnswer((realInvocation) => addComment3UseCaseFormState);
         when(addComment3UseCaseFormState.validate()).thenAnswer((realInvocation) => false);
         cubit.executeAddComment3(storyId: "storyId",);
       },
       expect: () => <FlowState>[],
     );

     blocTest<AddCubit3, FlowState>(
       'executeAddComment3 success true status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment3UseCaseKey.currentState).thenAnswer((realInvocation) => addComment3UseCaseFormState);
         when(addComment3UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content.text).thenAnswer((realInvocation) => "content");
         when(addComment3UseCase.execute(request : addComment3Request))
             .thenAnswer((realInvocation) async => Right(addComment3Response));
         cubit.executeAddComment3(storyId: "storyId",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         SuccessState(type: SuccessRendererType.none,message: "message",),
       ],
     );
     blocTest<AddCubit3, FlowState>(
       'executeAddComment3 success false status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment3UseCaseKey.currentState).thenAnswer((realInvocation) => addComment3UseCaseFormState);
         when(addComment3UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content.text).thenAnswer((realInvocation) => "content");
         when(addComment3UseCase.execute(request : addComment3Request))
                 .thenAnswer((realInvocation) async => Right(addComment3Response..success = false));
         cubit.executeAddComment3(storyId: "storyId",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         ErrorState(type: ErrorRendererType.toast,message: "message",),
       ],
     );

   blocTest<AddCubit3, FlowState>(
     'executeAddComment3 failure METHOD',
     build: () => cubit,
     act: (cubit) {
       when(addComment3UseCaseKey.currentState).thenAnswer((realInvocation) => addComment3UseCaseFormState);
       when(addComment3UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content.text).thenAnswer((realInvocation) => "content");
         when(addComment3UseCase.execute(request : addComment3Request))
           .thenAnswer((realInvocation) async => Left(failure));
       cubit.executeAddComment3(storyId: "storyId",);
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
