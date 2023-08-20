import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/presentation/logic/get_addresses_cubit.dart';
import 'package:example/settings/domain/use-cases/get_addresses_use_case.dart';
import 'package:example/settings/domain/requests/get_addresses_request.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/state_renderer.dart';
import 'package:example/core/states.dart';
import 'package:example/core/failure.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/data/models/address_model.dart';
import 'dart:io';import 'dart:convert';import 'package:bloc_test/bloc_test.dart';import 'package:eitherx/eitherx.dart';import 'package:flutter_test/flutter_test.dart';import 'package:mockito/annotations.dart';import 'package:mockito/mockito.dart';import 'get_addresses_cubit_test.mocks.dart';
 @GenerateNiceMocks([
   MockSpec<GetAddressesUseCase>(),
 ])
 void main() {
   late GetAddressesCubit cubit;
   late GetAddressesUseCase getAddressesUseCase;
   late GetAddressesRequest request;
   late BaseResponse<List<AddressModel>?> response;
   late Failure failure;
   setUp(() async {
     getAddressesUseCase = MockGetAddressesUseCase();
     request = GetAddressesRequest(page: 0,limit: 0,);
///[GetAddresses]
response = BaseResponse<List<AddressModel>?>(
message: 'message',
success: true,
data: List.generate(
2,
(index) =>
AddressModel.fromJson(json('expected_address_model')),
));
     failure = Failure(1, '');
     cubit = GetAddressesCubit(getAddressesUseCase,
     request,
     );
   });
 group('GetAddressesCubit CUBIT', () {
     blocTest<GetAddressesCubit, FlowState>(
       'getAddresses failure METHOD',
       build: () => cubit,
       act: (cubit) {
         when(getAddressesUseCase.execute(request : request))
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
     blocTest<GetAddressesCubit, FlowState>(
       'getAddresses success METHOD',
       build: () => cubit,
       act: (cubit) {
         when(getAddressesUseCase.execute(request : request))
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
