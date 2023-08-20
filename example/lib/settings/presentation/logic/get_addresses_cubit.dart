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
import 'package:example/settings/domain/use-cases/get_addresses_use_case.dart';
import 'package:example/settings/domain/requests/get_addresses_request.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/address_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';

///[GetAddressesCubit]
///[Implementation]
@injectable
class GetAddressesCubit extends Cubit<FlowState> {
final GetAddressesUseCase _getAddressesUseCase;
final GetAddressesRequest request;
late final PagewiseLoadController<AddressEntity> pagewiseController;
GetAddressesCubit(this._getAddressesUseCase,
this.request,
) : super(ContentState());
void init() {
pagewiseController = PagewiseLoadController<AddressEntity>(
pageSize: 10,
pageFuture: (page) {
return execute(page : page!,limit : page * 10);
},
);
}
String userId = "";Future<List<AddressEntity>> execute({required int page,required int limit, }) async {
List<AddressEntity> addresses = [];
request.userId = userId;
request.page = page;
request.limit = limit;
final res = await _getAddressesUseCase.execute(
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
addresses = data.data!;
}
});
return addresses;
}
void setUserId(String value){
userId = value;
}
}
