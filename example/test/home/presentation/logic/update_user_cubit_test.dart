import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/presentation/logic/update_user_cubit.dart';
import 'package:example/home/domain/use-cases/update_user_use_case.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/home/data/models/governorate_model.dart';
import 'package:example/home/data/models/result_model.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'dart:io';import 'dart:convert';import 'package:bloc_test/bloc_test.dart';import 'package:eitherx/eitherx.dart';import 'package:flutter_test/flutter_test.dart';import 'package:mockito/annotations.dart';import 'package:mockito/mockito.dart';import 'package:request_builder/request_builder.dart';import 'package:mwidgets/mwidgets.dart';import 'update_user_cubit_test.mocks.dart';
 @GenerateNiceMocks([
   MockSpec<UpdateUserUseCase>(),
 ])
 void main() {
   late UpdateUserCubit cubit;
   late UpdateUserUseCase updateUserUseCase;
   late BaseResponse<DeviceSettingsModel?> response;
   late Failure failure;
   setUp(() async {
     updateUserUseCase = MockUpdateUserUseCase();
///[UpdateUser]
response = BaseResponse<DeviceSettingsModel?>(
message: 'message',
success: true,
data: DeviceSettingsModel.fromJson(json('expected_device_settings_model')),);
     failure = Failure(1, '');
     cubit = UpdateUserCubit(updateUserUseCase,
     );
   });
 group('UpdateUserCubit CUBIT', () {
     blocTest<UpdateUserCubit, FlowState>(
       'updateUser success true status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(updateUserUseCase.execute(request : 0))
             .thenAnswer((realInvocation) async => Right(response));
         cubit.execute(firebaseToken: 0,);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         SuccessState(type: SuccessRendererType.content,message: "message",),
       ],
     );
     blocTest<UpdateUserCubit, FlowState>(
       'updateUser success false status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(updateUserUseCase.execute(request : 0))
                 .thenAnswer((realInvocation) async => Right(response..success = false));
         cubit.execute(firebaseToken: 0,);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         ErrorState(type: ErrorRendererType.toast,message: "message",),
       ],
     );

   blocTest<UpdateUserCubit, FlowState>(
     'updateUser failure METHOD',
     build: () => cubit,
     act: (cubit) {
         when(updateUserUseCase.execute(request : 0))
           .thenAnswer((realInvocation) async => Left(failure));
       cubit.execute(firebaseToken: 0,);
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
