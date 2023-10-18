import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:eitherx/eitherx.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/use-cases/get_cache_update_user_use_case.dart';
import 'package:example/home/presentation/logic/get_cache_update_user_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:request_builder/request_builder.dart';

import 'get_cache_update_user_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetCacheUpdateUserUseCase>(),
])
void main() {
  late GetCacheUpdateUserCubit cubit;
  late GetCacheUpdateUserUseCase getCacheUpdateUserUseCase;
  late DeviceSettingsModel response;
  late Failure failure;
  setUp(() async {
    getCacheUpdateUserUseCase = MockGetCacheUpdateUserUseCase();

    ///[GetCacheUpdateUser]
    response =
        DeviceSettingsModel.fromJson(json('expected_device_settings_model'));
    failure = Failure(1, '');
    cubit = GetCacheUpdateUserCubit(getCacheUpdateUserUseCase);
  });
  group('GetCacheUpdateUserCubit CUBIT', () {
    blocTest<GetCacheUpdateUserCubit, FlowState>(
      'getCacheUpdateUser failure METHOD',
      build: () => cubit,
      act: (cubit) {
        when(getCacheUpdateUserUseCase.execute())
            .thenAnswer((realInvocation) => Left(failure));
        cubit.execute();
      },
      expect: () => <FlowState>[
        const LoadingState(type: LoadingRendererType.popup),
        ErrorState(
          type: ErrorRendererType.toast,
          message: failure.message,
        ),
      ],
    );
    blocTest<GetCacheUpdateUserCubit, FlowState>(
      'getCacheUpdateUser success METHOD',
      build: () => cubit,
      act: (cubit) {
        when(getCacheUpdateUserUseCase.execute())
            .thenAnswer((realInvocation) => Right(response));
        cubit.execute();
      },
      expect: () => <FlowState>[
        const LoadingState(type: LoadingRendererType.popup),
        const ContentState(),
      ],
    );
  });
}

///[FromJson]
Map<String, dynamic> json(String path) {
  return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
