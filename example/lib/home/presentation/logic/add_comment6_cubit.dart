import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/requests/add_comment6_request.dart';
import 'package:example/home/domain/use-cases/add_comment6_use_case.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:request_builder/request_builder.dart';

///[AddComment6Cubit]
///[Implementation]
@injectable
class AddComment6Cubit extends Cubit<FlowState> {
  final AddComment6UseCase _addComment6UseCase;
  final AddComment6Request request;
  final GlobalKey<FormState> formKey;
  final TextEditingController content;

  AddComment6Cubit(
    this._addComment6UseCase,
    this.formKey,
    this.request,
    this.content,
  ) : super(const ContentState());

  DeviceSettingsEntity? addComment6;

  Future<void> execute({
    required String storyId,
  }) async {
    if (formKey.currentState!.validate()) {
      request.content = content.text;
      request.storyId = storyId;
      emit(const LoadingState(type: LoadingRendererType.popup));
      final res = await _addComment6UseCase.execute(
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
            addComment6 = data.data!;
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
