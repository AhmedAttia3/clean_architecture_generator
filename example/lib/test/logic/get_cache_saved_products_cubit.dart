import 'package:eitherx/eitherx.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/core/cubit/state_renderer/states.dart';
import 'package:example/core/consts/fold.dart';
import 'package:example/core/cubit/state_renderer/state_renderer.dart';
import 'package:example/test/repository/requests/get_saved_products_request.dart';
import 'package:example/test/repository/use-cases/get_cache_saved_products_use_case.dart';

@injectable
class GetCacheSavedProductsCubit extends Cubit<FlowState> {
final GetCacheSavedProductsUseCase _getSavedProductsUseCase;
double? savedProducts;
GetCacheSavedProductsCubit(this._getSavedProductsUseCase) : super(ContentState());
void execute() {
emit(LoadingState(type: StateRendererType.fullScreenLoading));
final res =  _getSavedProductsUseCase.execute();
res.right((data) {
savedProducts = data;
emit(ContentState());
});
res.left((failure) {
emit(ErrorState(
type: StateRendererType.toastError,
message: failure.message,
));
});
}
}
