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
import 'package:flutter_pagewise/flutter_pagewise.dart';import 'package:example/test/repository/use-cases/get_saved_products_use_case.dart';
import 'package:example/test/repository/requests/get_saved_products_request.dart';

///[GetSavedProductsCubit]
///[Implementation]
@injectable
class GetSavedProductsCubit extends Cubit<FlowState> {
final GetSavedProductsUseCase _getSavedProductsUseCase;
late final PagewiseLoadController<double> pagewiseController;
GetSavedProductsCubit(this._getSavedProductsUseCase,
) : super(ContentState());
void init() {
pagewiseController = PagewiseLoadController<double>(
pageSize: 10,
pageFuture: (page) {
final offset = page ?? 0;
return execute(page: offset, limit: offset * 10);
},
);
}
Future<double> execute({required int page,required int limit, }) async {
double savedProducts = [];
final res = await _getSavedProductsUseCase.execute(
request : GetSavedProductsRequest(page: page,limit: limit,),
);
res.left((failure) {
emit(ErrorState(
type: StateRendererType.toastError,
message: failure.message,
));
});
res.right((data) {
if(data.data != null){
savedProducts = data.data!;
}
});
return savedProducts;
}
}
