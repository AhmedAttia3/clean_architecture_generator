import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/core/states.dart';
import 'package:example/core/fold.dart';
import 'package:example/core/state_renderer.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:example/settings/domain/use-cases/get_otp_use_case.dart';
import 'package:example/settings/domain/requests/get_otp_request.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/address_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';

///[GetOtpCubit]
///[Implementation]
@injectable
class GetOtpCubit extends Cubit<FlowState> {
final GetOtpUseCase _getOtpUseCase;
final GetOtpRequest request;
late final PagewiseLoadController<OtpEntity> pagewiseController;
GetOtpCubit(this._getOtpUseCase,
this.request,
) : super(ContentState());
void init() {
pagewiseController = PagewiseLoadController<OtpEntity>(
pageSize: 10,
pageFuture: (page) {
return execute(page : page!,limit : page * 10);
},
);
}
String userId = "";Future<List<OtpEntity>> execute({required int page,required int limit, }) async {
List<OtpEntity> otp = [];
request.userId = userId;
request.page = page;
request.limit = limit;
final res = await _getOtpUseCase.execute(
request : request,
);
res.left((failure) {
emit(ErrorState(
type: StateRendererType.toastError,
message: failure.message,
));
});
res.right((data) {
if(data.data != null){
otp = data.data!;
}
});
return otp;
}
void setUserId(String value){
userId = value;
}
}
