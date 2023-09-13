import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_builder/request_builder.dart';
import 'package:example/home/domain/use-cases/get_result_use_case.dart';
import 'package:example/home/domain/requests/get_result_request.dart';
import 'package:example/home/domain/entities/governorate_entity.dart';
import 'package:example/home/domain/entities/result_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

///[GetResultCubit]
///[Implementation]
@injectable
class GetResultCubit extends Cubit<FlowState> {
final GetResultUseCase _getResultUseCase;
final GetResultRequest request;
GetResultCubit(this._getResultUseCase,
this.request,
) : super(const ContentState());

ResultEntity? result;


Future<void> execute({required int countryId,required int termId,required String studentName,required String sittingNumber, }) async {
request.countryId = countryId;
request.termId = termId;
request.studentName = studentName;
request.sittingNumber = sittingNumber;
emit(const LoadingState(type: LoadingRendererType.popup));
final res = await _getResultUseCase.execute(
request : request,
);
res.left((failure) {
emit(ErrorState(type: ErrorRendererType.toast,message: failure.message,));
});
res.right((data) {
if (data.success) {
if(data.data != null){
result = data.data!;
}
emit(SuccessState(type: SuccessRendererType.content,message: data.message,));
} else {
emit(ErrorState(type: ErrorRendererType.toast,message: data.message,));
}
});
}
}
