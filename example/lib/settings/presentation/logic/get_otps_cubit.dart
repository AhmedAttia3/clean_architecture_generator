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
import 'package:example/settings/domain/use-cases/get_otps_use_case.dart';
import 'package:example/settings/domain/requests/get_otps_request.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/address_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';

///[GetOTPsCubit]
///[Implementation]
@injectable
class GetOTPsCubit extends Cubit<FlowState> {
final GetOTPsUseCase _getOTPsUseCase;
final GetOTPsRequest request;
late final PagewiseLoadController<OtpEntity> pagewiseController;
GetOTPsCubit(this._getOTPsUseCase,
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
List<OtpEntity> oTPs = [];
request.userId = userId;
request.page = page;
request.limit = limit;
final res = await _getOTPsUseCase.execute(
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
oTPs = data.data!;
}
});
return oTPs;
}
void setUserId(String value){
userId = value;
}
}
