import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/presentation/logic/get_otps_cubit.dart';
import 'package:example/settings/domain/use-cases/get_otps_use_case.dart';
import 'package:example/settings/domain/requests/get_otps_request.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/state_renderer.dart';
import 'package:example/core/states.dart';
import 'package:example/core/failure.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/address_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'dart:io';import 'dart:convert';import 'package:bloc_test/bloc_test.dart';import 'package:eitherx/eitherx.dart';import 'package:flutter_test/flutter_test.dart';import 'package:mockito/annotations.dart';import 'package:mockito/mockito.dart';import 'get_otps_cubit_test.mocks.dart';
 @GenerateNiceMocks([
   MockSpec<GetOTPsUseCase>(),
 ])
 void main() {
   late GetOTPsCubit cubit;
   late GetOTPsUseCase getOTPsUseCase;
   late GetOTPsRequest request;
   late BaseResponse<List<OtpModel>?> response;
   late Failure failure;
   setUp(() async {
     getOTPsUseCase = MockGetOTPsUseCase();
     request = GetOTPsRequest(page: 0,limit: 0,);
///[GetOTPs]
response = BaseResponse<List<OtpModel>?>(
message: 'message',
success: true,
data: List.generate(
2,
(index) =>
OtpModel.fromJson(json('expected_otp_model')),
));
     failure = Failure(1, '');
     cubit = GetOTPsCubit(getOTPsUseCase,
     request,
     );
   });
 group('GetOTPsCubit CUBIT', () {
     blocTest<GetOTPsCubit, FlowState>(
       'getOTPs failure METHOD',
       build: () => cubit,
       act: (cubit) {
         when(getOTPsUseCase.execute(request : request))
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
     blocTest<GetOTPsCubit, FlowState>(
       'getOTPs success METHOD',
       build: () => cubit,
       act: (cubit) {
         when(getOTPsUseCase.execute(request : request))
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
