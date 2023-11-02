import 'dart:io';
import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:example/core/base/no_params.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_builder/request_builder.dart';
import 'package:example/home/domain/use-cases/add_comment_use_case.dart';
import 'package:example/home/domain/use-cases/add_comment2_use_case.dart';
import 'package:example/home/domain/requests/add_comment_request.dart';
import 'package:example/home/domain/requests/add_comment2_request.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

///[AddCubit]
///[Implementation]
@injectable
class AddCubit extends Cubit<FlowState> {
///[AddCommentUseCase]
final AddCommentUseCase _addCommentUseCase;
final AddCommentRequest addCommentRequest;
final GlobalKey<FormState> addCommentFormKey;
final TextEditingController content1;

///[AddComment2UseCase]
final AddComment2UseCase _addComment2UseCase;
final AddComment2Request addComment2Request;
final GlobalKey<FormState> addComment2FormKey;
final TextEditingController content2;

AddCubit(
this._addCommentUseCase,
this.addCommentFormKey,
this.addCommentRequest,
this.content1,
this._addComment2UseCase,
this.addComment2FormKey,
this.addComment2Request,
this.content2,
) : super(const ContentState());

DeviceSettingsEntity? addComment;


Future<void> executeAddComment({required String  storyId1, }) async {
if (addCommentFormKey.currentState!.validate()) {
addCommentRequest.content1 =
content1.text;
addCommentRequest.storyId1 = storyId1;
emit(const LoadingState(type: LoadingRendererType.popup));
final res = await _addCommentUseCase.execute(
request : addCommentRequest,
);
res.left((failure) {
emit(ErrorState(type: ErrorRendererType.toast,message: failure.message,));
});
res.right((data) {
if (data.success) {
if(data.data != null){
addComment = data.data!;
}
emit(SuccessState(type: SuccessRendererType.none,message: data.message,));
} else {
emit(ErrorState(type: ErrorRendererType.toast,message: data.message,));
}
});
}
}
DeviceSettingsEntity? addComment2;


Future<void> executeAddComment2({required String  storyId2, }) async {
if (addComment2FormKey.currentState!.validate()) {
addComment2Request.content2 =
content2.text;
addComment2Request.storyId2 = storyId2;
emit(const LoadingState(type: LoadingRendererType.popup));
final res = await _addComment2UseCase.execute(
request : addComment2Request,
);
res.left((failure) {
emit(ErrorState(type: ErrorRendererType.toast,message: failure.message,));
});
res.right((data) {
if (data.success) {
if(data.data != null){
addComment2 = data.data!;
}
emit(SuccessState(type: SuccessRendererType.none,message: data.message,));
} else {
emit(ErrorState(type: ErrorRendererType.toast,message: data.message,));
}
});
}
}
}
