import 'package:clean_architecture_generator/clean_architecture_generator.dart';

@CleanArchitecture
class Settings implements CleanArchitectureSetUp {
  @override
  List<CleanMethod> methods() {
    return [
      const CleanMethod(
        name: "login",
        endPoint: "/login",
        response: "BaseResponse<UserModel?>",
        methodType: MethodType.POST,
        requestType: RequestType.Fields,
        isCache: true,
        parameters: [
          Param(
            name: 'email',
            type: ParamType.Field,
            dataType: ParamDataType.String,
            prop: ParamProp.TextController,
          ),
          Param(
            name: 'password',
            type: ParamType.Field,
            dataType: ParamDataType.String,
            prop: ParamProp.TextController,
          ),
        ],
      ),
      const CleanMethod(
        name: "getUsers",
        endPoint: "/getUsers",
        response: "BaseResponse<List<UserModel>?>",
        methodType: MethodType.GET,
        requestType: RequestType.Fields,
        isPaging: true,
        parameters: [
          Param(
            name: 'page',
            type: ParamType.Field,
            dataType: ParamDataType.int,
          ),
          Param(
            name: 'limit',
            type: ParamType.Field,
            dataType: ParamDataType.int,
          ),
        ],
      ),
    ];
  }
}
