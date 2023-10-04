import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_builder/request_builder.dart';
import 'package:example/home/domain/use-cases/get_governorates_use_case.dart';
import 'package:example/home/domain/entities/governorate_entity.dart';
import 'package:example/home/domain/entities/result_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

///[GetGovernoratesCubit]
///[Implementation]
@injectable
class GetGovernoratesCubit extends Cubit<FlowState> {
final GetGovernoratesUseCase _getGovernoratesUseCase;
GetGovernoratesCubit(this._getGovernoratesUseCase,
) : super(const ContentState());

List<GovernorateEntity> governorates = [];


Future<void> execute() async {
emit(const LoadingState(type: LoadingRendererType.popup));
final res = await _getGovernoratesUseCase.execute(
);
res.left((failure) {
emit(ErrorState(type: ErrorRendererType.toast,message: failure.message,));
});
res.right((data) {
if (data.success) {
if(data.data != null){
governorates = data.data!;
}
emit(SuccessState(type: SuccessRendererType.content,message: data.message,));
} else {
emit(ErrorState(type: ErrorRendererType.toast,message: data.message,));
}
});
}
}
