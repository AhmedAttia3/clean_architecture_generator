import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/requests/add_comment_request.dart';
import 'package:example/home/domain/use-cases/add_comment_use_case.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:request_builder/request_builder.dart';

///[AddCommentCubit]
///[Implementation]
@injectable
class AddCommentCubit extends Cubit<FlowState> {
  final AddCommentUseCase _addCommentUseCase;
  final AddCommentRequest request;
  final GlobalKey<FormState> formKey;
  final TextEditingController content;

  AddCommentCubit(
    this._addCommentUseCase,
    this.formKey,
    this.request,
    this.content,
  ) : super(const ContentState());

  DeviceSettingsEntity? addComment;

  Future<void> execute({
    required String storyId,
  }) async {
    if (formKey.currentState!.validate()) {
      request.content = content.text;
      request.storyId = storyId;
      emit(const LoadingState(type: LoadingRendererType.popup));
      final res = await _addCommentUseCase.execute(
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
            addComment = data.data!;
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
