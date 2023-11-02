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
import 'package:example/home/domain/use-cases/add_comment5_use_case.dart';
import 'package:example/home/domain/requests/add_comment5_request.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

///[AddCubit5]
///[Implementation]
@injectable
class AddCubit5 extends Cubit<FlowState> {
///[AddComment5UseCase]
final AddComment5UseCase _addComment5UseCase;
final AddComment5Request addComment5Request;
final GlobalKey<FormState> addComment5FormKey;
final TextEditingController content;

AddCubit5(
this._addComment5UseCase,
this.addComment5FormKey,
this.addComment5Request,
this.content,
) : super(const ContentState());

DeviceSettingsEntity? addComment5;


Future<void> executeAddComment5({required String  storyId, }) async {
if (addComment5FormKey.currentState!.validate()) {
addComment5Request.content =
content.text;
addComment5Request.storyId = storyId;
emit(const LoadingState(type: LoadingRendererType.popup));
final res = await _addComment5UseCase.execute(
request : addComment5Request,
);
res.left((failure) {
emit(ErrorState(type: ErrorRendererType.toast,message: failure.message,));
});
res.right((data) {
if (data.success) {
if(data.data != null){
addComment5 = data.data!;
}
emit(SuccessState(type: SuccessRendererType.none,message: data.message,));
} else {
emit(ErrorState(type: ErrorRendererType.toast,message: data.message,));
}
});
}
}
}
