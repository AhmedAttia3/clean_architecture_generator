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
import 'package:example/home/domain/use-cases/add_comment4_use_case.dart';
import 'package:example/home/domain/requests/add_comment4_request.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

///[AddCubit4]
///[Implementation]
@injectable
class AddCubit4 extends Cubit<FlowState> {
///[AddComment4UseCase]
final AddComment4UseCase _addComment4UseCase;
final AddComment4Request addComment4Request;
final GlobalKey<FormState> addComment4FormKey;
final TextEditingController content;

AddCubit4(
this._addComment4UseCase,
this.addComment4FormKey,
this.addComment4Request,
this.content,
) : super(const ContentState());

DeviceSettingsEntity? addComment4;


Future<void> executeAddComment4({required String  storyId, }) async {
if (addComment4FormKey.currentState!.validate()) {
addComment4Request.content =
content.text;
addComment4Request.storyId = storyId;
emit(const LoadingState(type: LoadingRendererType.popup));
final res = await _addComment4UseCase.execute(
request : addComment4Request,
);
res.left((failure) {
emit(ErrorState(type: ErrorRendererType.toast,message: failure.message,));
});
res.right((data) {
if (data.success) {
if(data.data != null){
addComment4 = data.data!;
}
emit(SuccessState(type: SuccessRendererType.none,message: data.message,));
} else {
emit(ErrorState(type: ErrorRendererType.toast,message: data.message,));
}
});
}
}
}
