import 'package:eitherx/eitherx.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';import 'dart:developer';import 'package:flutter/foundation.dart';
///[kPrint]
///[Implementation]
void kPrint(dynamic data) {
if (kDebugMode) {
_pr(data.toString());
} else if (data is Map) {
_pr(jsonEncode(data));
} else {
_pr(data.toString());
}
}


void _pr(String data) {
if (data.length > 500) {
log(data);
} else {
print(data);
}
log(StackTrace.current.toString().split('\n')[2]);
}
