import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/presentation/logic/add_cubit5.dart';
import 'package:example/home/domain/requests/add_comment5_request.dart';
import 'package:example/home/domain/use-cases/add_comment5_use_case.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'dart:io';import 'dart:convert';import 'package:flutter/material.dart';import 'package:bloc_test/bloc_test.dart';import 'package:eitherx/eitherx.dart';import 'package:flutter_test/flutter_test.dart';import 'package:mockito/annotations.dart';import 'package:mockito/mockito.dart';import 'package:request_builder/request_builder.dart';import 'package:mwidgets/mwidgets.dart';import 'add_cubit5_test.mocks.dart';
 @GenerateNiceMocks([
   MockSpec<TextEditingController>(),
   MockSpec<GlobalKey<FormState>>(),
   MockSpec<FormState>(),
   MockSpec<AddComment5UseCase>(),
 ])
 void main() {
   late AddCubit5 cubit;
   late AddComment5UseCase addComment5UseCase;
   late TextEditingController content;
   late GlobalKey<FormState> addComment5UseCaseKey;
   late FormState addComment5UseCaseFormState;
   late AddComment5Request addComment5Request;
   late BaseResponse<DeviceSettingsModel?> addComment5Response;
   late Failure failure;
   setUp(() async {
     content = MockTextEditingController();
     addComment5UseCaseKey = MockGlobalKey();
     addComment5UseCaseFormState = MockFormState();
     addComment5UseCase = MockAddComment5UseCase();
   addComment5Request = AddComment5Request(storyId: "storyId",content: "content",);
///[AddComment5]
addComment5Response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
     failure = Failure(1, '');
     cubit = AddCubit5(
     addComment5UseCase,
     addComment5UseCaseKey,
     addComment5Request,
     content,
     );
   });
 group('AddCubit5 CUBIT', () {
///[addComment5UseCase]
     blocTest<AddCubit5, FlowState>(
       'executeAddComment5 validation error METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment5UseCaseKey.currentState).thenAnswer((realInvocation) => addComment5UseCaseFormState);
         when(addComment5UseCaseFormState.validate()).thenAnswer((realInvocation) => false);
         cubit.executeAddComment5(storyId: "storyId",);
       },
       expect: () => <FlowState>[],
     );

     blocTest<AddCubit5, FlowState>(
       'executeAddComment5 success true status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment5UseCaseKey.currentState).thenAnswer((realInvocation) => addComment5UseCaseFormState);
         when(addComment5UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content.text).thenAnswer((realInvocation) => "content");
         when(addComment5UseCase.execute(request : addComment5Request))
             .thenAnswer((realInvocation) async => Right(addComment5Response));
         cubit.executeAddComment5(storyId: "storyId",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         SuccessState(type: SuccessRendererType.none,message: "message",),
       ],
     );
     blocTest<AddCubit5, FlowState>(
       'executeAddComment5 success false status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(addComment5UseCaseKey.currentState).thenAnswer((realInvocation) => addComment5UseCaseFormState);
         when(addComment5UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content.text).thenAnswer((realInvocation) => "content");
         when(addComment5UseCase.execute(request : addComment5Request))
                 .thenAnswer((realInvocation) async => Right(addComment5Response..success = false));
         cubit.executeAddComment5(storyId: "storyId",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         ErrorState(type: ErrorRendererType.toast,message: "message",),
       ],
     );

   blocTest<AddCubit5, FlowState>(
     'executeAddComment5 failure METHOD',
     build: () => cubit,
     act: (cubit) {
       when(addComment5UseCaseKey.currentState).thenAnswer((realInvocation) => addComment5UseCaseFormState);
       when(addComment5UseCaseFormState.validate()).thenAnswer((realInvocation) => true);
         when(content.text).thenAnswer((realInvocation) => "content");
         when(addComment5UseCase.execute(request : addComment5Request))
           .thenAnswer((realInvocation) async => Left(failure));
       cubit.executeAddComment5(storyId: "storyId",);
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
