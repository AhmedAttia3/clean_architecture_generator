import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/requests/add_comment2_request.dart';
import 'package:example/home/domain/use-cases/add_comment2_use_case.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:request_builder/request_builder.dart';

///[AddComment2Cubit]
///[Implementation]
@injectable
class AddComment2Cubit extends Cubit<FlowState> {
  final AddComment2UseCase _addComment2UseCase;
  final AddComment2Request request;
  final GlobalKey<FormState> formKey;
  final TextEditingController content;

  AddComment2Cubit(
    this._addComment2UseCase,
    this.formKey,
    this.request,
    this.content,
  ) : super(const ContentState());

  DeviceSettingsEntity? addComment2;

  Future<void> execute({
    required String storyId,
  }) async {
    if (formKey.currentState!.validate()) {
      request.content = content.text;
      request.storyId = storyId;
      emit(const LoadingState(type: LoadingRendererType.popup));
      final res = await _addComment2UseCase.execute(
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
            addComment2 = data.data!;
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
