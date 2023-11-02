import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:eitherx/eitherx.dart';
import 'package:example/home/data/models/device_settings_model.dart';
import 'package:example/home/domain/use-cases/get_cache_add_comment5_use_case.dart';
import 'package:example/home/presentation/logic/get_cache_add_cubit5_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:request_builder/request_builder.dart';

import 'get_cache_add_cubit5_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetCacheAddComment5UseCase>(),
])
void main() {
  late GetCacheAddCubit5Cubit cubit;
  late GetCacheAddComment5UseCase getCacheAddComment5UseCase;
  late DeviceSettingsModel response;
  late Failure failure;
  setUp(() async {
    getCacheAddComment5UseCase = MockGetCacheAddComment5UseCase();

    ///[GetCacheAddComment5]
    response =
        DeviceSettingsModel.fromJson(json('expected_device_settings_model'));
    failure = Failure(1, '');
    cubit = GetCacheAddCubit5Cubit(getCacheAddComment5UseCase);
  });
  group('GetCacheAddCubit5Cubit CUBIT', () {
    blocTest<GetCacheAddCubit5Cubit, FlowState>(
      'getCacheAddComment5 failure METHOD',
      build: () => cubit,
      act: (cubit) {
        when(getCacheAddComment5UseCase.execute())
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
    blocTest<GetCacheAddCubit5Cubit, FlowState>(
      'getCacheAddComment5 success METHOD',
      build: () => cubit,
      act: (cubit) {
        when(getCacheAddComment5UseCase.execute())
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
