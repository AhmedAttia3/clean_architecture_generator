import 'dart:convert';
import 'dart:io';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:eitherx/eitherx.dart';
import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/core/base/no_params.dart';
import 'package:example/home/data/models/governorate_model.dart';
import 'package:example/home/data/models/result_model.dart';
import 'package:example/home/domain/use-cases/add_favorite_use_case.dart';
import 'package:example/home/presentation/logic/add_favorite_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:request_builder/request_builder.dart';

import 'add_favorite_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AddFavoriteUseCase>(),
])
void main() {
  late AddFavoriteCubit cubit;
  late AddFavoriteUseCase addFavoriteUseCase;
  late BaseResponse<int> response;
  late Failure failure;
  setUp(() async {
    addFavoriteUseCase = MockAddFavoriteUseCase();

    ///[AddFavorite]
    response = BaseResponse<int>(
      message: 'message',
      success: true,
      data: 0,
    );
    failure = Failure(1, '');
    cubit = AddFavoriteCubit(
      addFavoriteUseCase,
    );
  });
  group('AddFavoriteCubit CUBIT', () {
    blocTest<AddFavoriteCubit, FlowState>(
      'addFavorite success true status METHOD',
      build: () => cubit,
      act: (cubit) {
        when(addFavoriteUseCase.execute(request: 0))
            .thenAnswer((realInvocation) async => Right(response));
        cubit.execute(
          countryId: 0,
        );
      },
      expect: () => <FlowState>[
        const LoadingState(type: LoadingRendererType.popup),
        SuccessState(
          type: SuccessRendererType.content,
          message: "message",
        ),
      ],
    );
    blocTest<AddFavoriteCubit, FlowState>(
      'addFavorite success false status METHOD',
      build: () => cubit,
      act: (cubit) {
        when(addFavoriteUseCase.execute(request: 0)).thenAnswer(
            (realInvocation) async => Right(response..success = false));
        cubit.execute(
          countryId: 0,
        );
      },
      expect: () => <FlowState>[
        const LoadingState(type: LoadingRendererType.popup),
        ErrorState(
          type: ErrorRendererType.toast,
          message: "message",
        ),
      ],
    );

    blocTest<AddFavoriteCubit, FlowState>(
      'addFavorite failure METHOD',
      build: () => cubit,
      act: (cubit) {
        when(addFavoriteUseCase.execute(request: 0))
            .thenAnswer((realInvocation) async => Left(failure));
        cubit.execute(
          countryId: 0,
        );
      },
      expect: () => <FlowState>[
        const LoadingState(type: LoadingRendererType.popup),
        ErrorState(
          type: ErrorRendererType.toast,
          message: failure.message,
        ),
      ],
    );
  });
}

///[FromJson]
Map<String, dynamic> json(String path) {
  return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
