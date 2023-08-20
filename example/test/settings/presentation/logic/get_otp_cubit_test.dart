import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/presentation/logic/get_otp_cubit.dart';
import 'package:example/settings/domain/use-cases/get_otp_use_case.dart';
import 'package:example/settings/domain/requests/get_otp_request.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/state_renderer.dart';
import 'package:example/core/states.dart';
import 'package:example/core/failure.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/address_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'dart:io';import 'dart:convert';import 'package:bloc_test/bloc_test.dart';import 'package:eitherx/eitherx.dart';import 'package:flutter_test/flutter_test.dart';import 'package:mockito/annotations.dart';import 'package:mockito/mockito.dart';import 'get_otp_cubit_test.mocks.dart';
 @GenerateNiceMocks([
   MockSpec<GetOtpUseCase>(),
 ])
 void main() {
   late GetOtpCubit cubit;
   late GetOtpUseCase getOtpUseCase;
   late GetOtpRequest request;
   late BaseResponse<List<OtpModel>?> response;
   late Failure failure;
   setUp(() async {
     getOtpUseCase = MockGetOtpUseCase();
     request = GetOtpRequest(page: 0,limit: 0,);
///[GetOtp]
response = BaseResponse<List<OtpModel>?>(
message: 'message',
success: true,
data: List.generate(
2,
(index) =>
OtpModel.fromJson(json('expected_otp_model')),
));
     failure = Failure(1, '');
     cubit = GetOtpCubit(getOtpUseCase,
     request,
     );
   });
 group('GetOtpCubit CUBIT', () {
     blocTest<GetOtpCubit, FlowState>(
       'getOtp failure METHOD',
       build: () => cubit,
       act: (cubit) {
         when(getOtpUseCase.execute(request : request))
             .thenAnswer((realInvocation) async => Left(failure));
         cubit.setUserId("userId");
         cubit.execute(page: 0,limit: 0,);
       },
       expect: () => <FlowState>[
         ErrorState(
           type: StateRendererType.toastError,
           message: failure.message,
         )
       ],
     );
     blocTest<GetOtpCubit, FlowState>(
       'getOtp success METHOD',
       build: () => cubit,
       act: (cubit) {
         when(getOtpUseCase.execute(request : request))
             .thenAnswer((realInvocation) async => Right(response));
         cubit.init();
         ///[page, limit]
         cubit.setUserId("userId");
         cubit.execute(page: 0,limit: 0,);
       },
       expect: () => <FlowState>[
       ],
     );
   });
 }
///[FromJson]
Map<String, dynamic> json(String path) {
 return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
