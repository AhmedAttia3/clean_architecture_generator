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
import 'package:example/home/domain/use-cases/add_comment3_use_case.dart';
import 'package:example/home/domain/requests/add_comment3_request.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

///[AddCubit3]
///[Implementation]
@injectable
class AddCubit3 extends Cubit<FlowState> {
///[AddComment3UseCase]
final AddComment3UseCase _addComment3UseCase;
final AddComment3Request addComment3Request;
final GlobalKey<FormState> addComment3FormKey;
final TextEditingController content;

AddCubit3(
this._addComment3UseCase,
this.addComment3FormKey,
this.addComment3Request,
this.content,
) : super(const ContentState());

DeviceSettingsEntity? addComment3;


Future<void> executeAddComment3({required String  storyId, }) async {
if (addComment3FormKey.currentState!.validate()) {
addComment3Request.content =
content.text;
addComment3Request.storyId = storyId;
emit(const LoadingState(type: LoadingRendererType.popup));
final res = await _addComment3UseCase.execute(
request : addComment3Request,
);
res.left((failure) {
emit(ErrorState(type: ErrorRendererType.toast,message: failure.message,));
});
res.right((data) {
if (data.success) {
if(data.data != null){
addComment3 = data.data!;
}
emit(SuccessState(type: SuccessRendererType.none,message: data.message,));
} else {
emit(ErrorState(type: ErrorRendererType.toast,message: data.message,));
}
});
}
}
}
