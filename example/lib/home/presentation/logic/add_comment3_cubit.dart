import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/requests/add_comment3_request.dart';
import 'package:example/home/domain/use-cases/add_comment3_use_case.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:request_builder/request_builder.dart';

///[AddComment3Cubit]
///[Implementation]
@injectable
class AddComment3Cubit extends Cubit<FlowState> {
  final AddComment3UseCase _addComment3UseCase;
  final AddComment3Request request;
  final GlobalKey<FormState> formKey;
  final TextEditingController content;

  AddComment3Cubit(
    this._addComment3UseCase,
    this.formKey,
    this.request,
    this.content,
  ) : super(const ContentState());

  DeviceSettingsEntity? addComment3;

  Future<void> execute({
    required String storyId,
  }) async {
    if (formKey.currentState!.validate()) {
      request.content = content.text;
      request.storyId = storyId;
      emit(const LoadingState(type: LoadingRendererType.popup));
      final res = await _addComment3UseCase.execute(
        request: request,
      );
      res.left((failure) {
        emit(ErrorState(
          type: ErrorRendererType.toast,
          message: failure.message,
        ));
      });
      res.right((data) {
        if (data.success) {
          if (data.data != null) {
            addComment3 = data.data!;
          }
          emit(SuccessState(
            type: SuccessRendererType.content,
            message: data.message,
          ));
        } else {
          emit(ErrorState(
            type: ErrorRendererType.toast,
            message: data.message,
          ));
        }
      });
    }
  }
}
