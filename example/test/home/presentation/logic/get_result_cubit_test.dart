import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/presentation/logic/get_result_cubit.dart';
import 'package:example/home/domain/use-cases/get_result_use_case.dart';
import 'package:example/home/domain/requests/get_result_request.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/home/data/models/governorate_model.dart';
import 'package:example/home/data/models/result_model.dart';
import 'dart:io';import 'dart:convert';import 'package:bloc_test/bloc_test.dart';import 'package:eitherx/eitherx.dart';import 'package:flutter_test/flutter_test.dart';import 'package:mockito/annotations.dart';import 'package:mockito/mockito.dart';import 'package:request_builder/request_builder.dart';import 'package:mwidgets/mwidgets.dart';import 'get_result_cubit_test.mocks.dart';
 @GenerateNiceMocks([
   MockSpec<GetResultUseCase>(),
 ])
 void main() {
   late GetResultCubit cubit;
   late GetResultUseCase getResultUseCase;
   late GetResultRequest request;
   late BaseResponse<ResultModel?> response;
   late Failure failure;
   setUp(() async {
     getResultUseCase = MockGetResultUseCase();
     request = GetResultRequest(countryId: 0,termId: 0,studentName: "studentName",sittingNumber: "sittingNumber",);
///[GetResult]
response = BaseResponse<ResultModel?>(
message: 'message',
success: true,
data: ResultModel.fromJson(json('expected_result_model')),);
     failure = Failure(1, '');
     cubit = GetResultCubit(getResultUseCase,
     request,
     );
   });
 group('GetResultCubit CUBIT', () {
     blocTest<GetResultCubit, FlowState>(
       'getResult success true status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(getResultUseCase.execute(request : request))
             .thenAnswer((realInvocation) async => Right(response));
         cubit.execute(countryId: 0,termId: 0,studentName: "studentName",sittingNumber: "sittingNumber",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         SuccessState(type: SuccessRendererType.content,message: "message",),
       ],
     );
     blocTest<GetResultCubit, FlowState>(
       'getResult success false status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(getResultUseCase.execute(request : request))
                 .thenAnswer((realInvocation) async => Right(response..success = false));
         cubit.execute(countryId: 0,termId: 0,studentName: "studentName",sittingNumber: "sittingNumber",);
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         ErrorState(type: ErrorRendererType.toast,message: "message",),
       ],
     );

   blocTest<GetResultCubit, FlowState>(
     'getResult failure METHOD',
     build: () => cubit,
     act: (cubit) {
         when(getResultUseCase.execute(request : request))
           .thenAnswer((realInvocation) async => Left(failure));
       cubit.execute(countryId: 0,termId: 0,studentName: "studentName",sittingNumber: "sittingNumber",);
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
