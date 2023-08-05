import 'package:example/core/fold.dart';
import 'package:example/core/state_renderer.dart';
import 'package:example/core/states.dart';
import 'package:example/settings/domain/requests/get_saved_products_request.dart';
import 'package:example/settings/domain/use-cases/get_saved_products_use_case.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:injectable/injectable.dart';

///[GetSavedProductsCubit]
///[Implementation]
@injectable
class GetSavedProductsCubit extends Cubit<FlowState> {
  final GetSavedProductsUseCase _getSavedProductsUseCase;
  late final PagewiseLoadController<ProductModel> pagewiseController;

  GetSavedProductsCubit(
    this._getSavedProductsUseCase,
  ) : super(ContentState());

  void init() {
    pagewiseController = PagewiseLoadController<ProductModel>(
      pageSize: 10,
      pageFuture: (page) {
        final offset = page ?? 0;
        return execute(page: offset, limit: offset * 10);
      },
    );
  }

  Future<List<ProductModel>> execute({
    required int page,
    required int limit,
  }) async {
    List<ProductModel> savedProducts = [];
    final res = await _getSavedProductsUseCase.execute(
      request: GetSavedProductsRequest(
        page: page,
        limit: limit,
      ),
    );
    res.left((failure) {
      emit(ErrorState(
        type: StateRendererType.toastError,
        message: failure.message,
      ));
    });
    res.right((data) {
      if (data.data != null) {
        savedProducts = data.data!;
      }
    });
    return savedProducts;
  }
}
