import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/presentation/logic/get_governorates_cubit.dart';
import 'package:example/home/domain/use-cases/get_governorates_use_case.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/home/data/models/governorate_model.dart';
import 'dart:io';import 'dart:convert';import 'package:bloc_test/bloc_test.dart';import 'package:eitherx/eitherx.dart';import 'package:flutter_test/flutter_test.dart';import 'package:mockito/annotations.dart';import 'package:mockito/mockito.dart';import 'package:request_builder/request_builder.dart';import 'package:mwidgets/mwidgets.dart';import 'get_governorates_cubit_test.mocks.dart';
 @GenerateNiceMocks([
   MockSpec<GetGovernoratesUseCase>(),
 ])
 void main() {
   late GetGovernoratesCubit cubit;
   late GetGovernoratesUseCase getGovernoratesUseCase;
   late BaseResponse<List<GovernorateModel>?> response;
   late Failure failure;
   setUp(() async {
     getGovernoratesUseCase = MockGetGovernoratesUseCase();
///[GetGovernorates]
response = BaseResponse<List<GovernorateModel>?>(
message: 'message',
success: true,
data: List.generate(
2,
(index) =>
GovernorateModel.fromJson(json('expected_governorate_model')),
));
     failure = Failure(1, '');
     cubit = GetGovernoratesCubit(getGovernoratesUseCase,
     );
   });
 group('GetGovernoratesCubit CUBIT', () {
     blocTest<GetGovernoratesCubit, FlowState>(
       'getGovernorates success true status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(getGovernoratesUseCase.execute())
             .thenAnswer((realInvocation) async => Right(response));
         cubit.execute();
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         SuccessState(type: SuccessRendererType.content,message: "message",),
       ],
     );
     blocTest<GetGovernoratesCubit, FlowState>(
       'getGovernorates success false status METHOD',
       build: () => cubit,
       act: (cubit) {
         when(getGovernoratesUseCase.execute())
                 .thenAnswer((realInvocation) async => Right(response..success = false));
         cubit.execute();
       },
       expect: () => <FlowState>[
         const LoadingState(type: LoadingRendererType.popup),
         ErrorState(type: ErrorRendererType.toast,message: "message",),
       ],
     );

   blocTest<GetGovernoratesCubit, FlowState>(
     'getGovernorates failure METHOD',
     build: () => cubit,
     act: (cubit) {
         when(getGovernoratesUseCase.execute())
           .thenAnswer((realInvocation) async => Left(failure));
       cubit.execute();
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
