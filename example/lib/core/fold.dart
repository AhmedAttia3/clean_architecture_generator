import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/core/failure.dart';
import 'package:example/core/print.dart';
import 'dart:developer';import 'package:eitherx/eitherx.dart';
extension OnEither<T> on Either<Failure, T> {
dynamic right(Function(T data) callBack) {
return fold(
(failure) {
kPrint('Error! $failure');
 },
(data) {
callBack(data);
return data;
},
);
}
dynamic left(Function(Failure failure) callBack) {
return fold(
(failure) {
kPrint(failure.code);
kPrint(failure.message);
callBack(failure);
return failure;
},
(data) {},
);
}
}
