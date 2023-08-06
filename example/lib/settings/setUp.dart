import 'package:clean_architecture_generator/clean_architecture_generator.dart';
import 'package:clean_architecture_generator/models/clean_method.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/settings/models/settings_model.dart';

class SetUp implements CleanArchitectureSetUp {
  @override
  List<CleanMethod> get methods {
    return [
      CleanMethod<BaseResponse<SettingsModel>>(
        name: "getAppInfo",
        endPoint: '/getAppInfo',
        response: ,
      )
    ];
  }
}
