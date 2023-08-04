import 'package:eitherx/eitherx.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/core/states.dart';
import 'package:example/core/fold.dart';
import 'package:example/core/state_renderer.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';import 'package:example/settings/domain/use-cases/get_app_use_case.dart';
import 'package:example/settings/domain/requests/get_app_request.dart';

///[GetAppCubit]
///[Implementation]
@injectable
class GetAppCubit extends Cubit<FlowState> {
final GetAppUseCase _getAppUseCase;
late final PagewiseLoadController<SettingsModel> pagewiseController;
GetAppCubit(this._getAppUseCase,
) : super(ContentState());
void init() {
pagewiseController = PagewiseLoadController<SettingsModel>(
pageSize: 10,
pageFuture: (page) {
final offset = page ?? 0;
return execute(page: offset, limit: offset * 10);
},
);
}
Future<List<SettingsModel>> execute({required int page,required int limit, }) async {
List<SettingsModel> app = [];
final res = await _getAppUseCase.execute(
request : GetAppRequest(page: page,limit: limit,),
);
res.left((failure) {
emit(ErrorState(
type: StateRendererType.toastError,
message: failure.message,
));
});
res.right((data) {
if(data.data != null){
app = data.data!;
}
});
return app;
}
}
