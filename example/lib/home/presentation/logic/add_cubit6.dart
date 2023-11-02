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
import 'package:example/home/domain/use-cases/add_comment6_use_case.dart';
import 'package:example/home/domain/use-cases/add_comment7_use_case.dart';
import 'package:example/home/domain/use-cases/add_comment8_use_case.dart';
import 'package:example/home/domain/requests/add_comment6_request.dart';
import 'package:example/home/domain/requests/add_comment7_request.dart';
import 'package:example/home/domain/requests/add_comment8_request.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

///[AddCubit6]
///[Implementation]
@injectable
class AddCubit6 extends Cubit<FlowState> {
///[AddComment6UseCase]
final AddComment6UseCase _addComment6UseCase;
final AddComment6Request addComment6Request;
final GlobalKey<FormState> addComment6FormKey;
final TextEditingController content1;

///[AddComment7UseCase]
final AddComment7UseCase _addComment7UseCase;
final AddComment7Request addComment7Request;
final GlobalKey<FormState> addComment7FormKey;
final TextEditingController content2;

///[AddComment8UseCase]
final AddComment8UseCase _addComment8UseCase;
final AddComment8Request addComment8Request;
final GlobalKey<FormState> addComment8FormKey;
final TextEditingController content3;

AddCubit6(
this._addComment6UseCase,
this.addComment6FormKey,
this.addComment6Request,
this.content1,
this._addComment7UseCase,
this.addComment7FormKey,
this.addComment7Request,
this.content2,
this._addComment8UseCase,
this.addComment8FormKey,
this.addComment8Request,
this.content3,
) : super(const ContentState());

DeviceSettingsEntity? addComment6;


Future<void> executeAddComment6({required String  storyId1, }) async {
if (addComment6FormKey.currentState!.validate()) {
addComment6Request.content1 =
content1.text;
addComment6Request.storyId1 = storyId1;
emit(const LoadingState(type: LoadingRendererType.popup));
final res = await _addComment6UseCase.execute(
request : addComment6Request,
);
res.left((failure) {
emit(ErrorState(type: ErrorRendererType.toast,message: failure.message,));
});
res.right((data) {
if (data.success) {
if(data.data != null){
addComment6 = data.data!;
}
emit(SuccessState(type: SuccessRendererType.none,message: data.message,));
} else {
emit(ErrorState(type: ErrorRendererType.toast,message: data.message,));
}
});
}
}
DeviceSettingsEntity? addComment7;


Future<void> executeAddComment7({required String  storyId2, }) async {
if (addComment7FormKey.currentState!.validate()) {
addComment7Request.content2 =
content2.text;
addComment7Request.storyId2 = storyId2;
emit(const LoadingState(type: LoadingRendererType.popup));
final res = await _addComment7UseCase.execute(
request : addComment7Request,
);
res.left((failure) {
emit(ErrorState(type: ErrorRendererType.toast,message: failure.message,));
});
res.right((data) {
if (data.success) {
if(data.data != null){
addComment7 = data.data!;
}
emit(SuccessState(type: SuccessRendererType.none,message: data.message,));
} else {
emit(ErrorState(type: ErrorRendererType.toast,message: data.message,));
}
});
}
}
DeviceSettingsEntity? addComment8;


Future<void> executeAddComment8({required String  storyId3, }) async {
if (addComment8FormKey.currentState!.validate()) {
addComment8Request.content3 =
content3.text;
addComment8Request.storyId3 = storyId3;
emit(const LoadingState(type: LoadingRendererType.popup));
final res = await _addComment8UseCase.execute(
request : addComment8Request,
);
res.left((failure) {
emit(ErrorState(type: ErrorRendererType.toast,message: failure.message,));
});
res.right((data) {
if (data.success) {
if(data.data != null){
addComment8 = data.data!;
}
emit(SuccessState(type: SuccessRendererType.none,message: data.message,));
} else {
emit(ErrorState(type: ErrorRendererType.toast,message: data.message,));
}
});
}
}
}
