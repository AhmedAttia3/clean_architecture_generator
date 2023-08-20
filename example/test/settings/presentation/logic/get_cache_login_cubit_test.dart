import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/presentation/logic/get_cache_login_cubit.dart';
import 'package:example/settings/domain/use-cases/get_cache_login_use_case.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/state_renderer.dart';
import 'package:example/core/states.dart';
import 'package:example/core/failure.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/address_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'dart:io';import 'dart:convert';import 'package:bloc_test/bloc_test.dart';import 'package:eitherx/eitherx.dart';import 'package:flutter_test/flutter_test.dart';import 'package:mockito/annotations.dart';import 'package:mockito/mockito.dart';import 'get_cache_login_cubit_test.mocks.dart';
 @GenerateNiceMocks([
   MockSpec<GetCacheLoginUseCase>(),
 ])
 void main() {
   late GetCacheLoginCubit cubit;
   late GetCacheLoginUseCase getCacheLoginUseCase;
   late UserModel response;
   late Failure failure;
   setUp(() async {
     getCacheLoginUseCase = MockGetCacheLoginUseCase();
///[GetCacheLogin]
response = 
 UserModel.fromJson(json('expected_user_model'));
     failure = Failure(1, '');
     cubit = GetCacheLoginCubit(getCacheLoginUseCase);
   });
 group('GetCacheLoginCubit CUBIT', () {
     blocTest<GetCacheLoginCubit, FlowState>(
       'getCacheLogin failure METHOD',
       build: () => cubit,
       act: (cubit) {
         when(getCacheLoginUseCase.execute())
             .thenAnswer((realInvocation) => Left(failure));
         cubit.execute();
       },
       expect: () => <FlowState>[
         LoadingState(type: StateRendererType.fullScreenLoading),
         ErrorState(
           type: StateRendererType.toastError,
           message: failure.message,
         )
       ],
     );
     blocTest<GetCacheLoginCubit, FlowState>(
       'getCacheLogin success METHOD',
       build: () => cubit,
       act: (cubit) {
         when(getCacheLoginUseCase.execute())
             .thenAnswer((realInvocation) => Right(response));
         cubit.execute();
       },
       expect: () => <FlowState>[
         LoadingState(type: StateRendererType.fullScreenLoading),
       ContentState(),
       ],
     );
   });
 }
///[FromJson]
Map<String, dynamic> json(String path) {
 return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
