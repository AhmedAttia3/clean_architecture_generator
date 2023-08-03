import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/consts/fold.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/cubit/base_response/base_response.dart';
import 'package:example/core/cubit/state_renderer/state_renderer.dart';
import 'package:example/core/cubit/state_renderer/states.dart';
import 'package:example/core/failure.dart';
import 'package:example/test/repository/requests/save_product_request.dart';
import 'package:example/test/repository/use-cases/save_product_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

///[SaveProductCubit]
///[Implementation]
@injectable
class SaveProductCubit extends Cubit<FlowState> {
  final SaveProductUseCase _saveProductUseCase;
  final GlobalKey<FormState> formKey;
  final TextEditingController type;

  SaveProductCubit(
    this._saveProductUseCase,
    this.formKey,
    this.type,
  ) : super(ContentState());

  String productId = "";

  Future<void> execute() async {
    if (formKey.currentState!.validate()) {
      emit(LoadingState(type: StateRendererType.popUpLoading));
      final res = await _saveProductUseCase.execute(
          request: SaveProductRequest(
        type: type.text,
        productId: productId,
      ));
      res.left((failure) {
        emit(ErrorState(
          type: StateRendererType.toastError,
          message: failure.message,
        ));
      });
      res.right((data) {
        if (data.success) {
          emit(SuccessState(
            message: data.message,
            type: StateRendererType.contentState,
          ));
        } else {
          emit(SuccessState(
            message: data.message,
            type: StateRendererType.toastError,
          ));
        }
      });
    }
  }

  void setProductId(String value) {
    productId = value;
  }
}
