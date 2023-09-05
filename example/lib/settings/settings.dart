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
        requestType: RequestType.Body,
        isCache: true,
        methodType: MethodType.POST,
        parameters: [
          Param(
            name: 'email',
            type: ParamType.Field,
            prop: ParamProp.TextController,
          ),
          Param(
            name: 'password',
            type: ParamType.Field,
            prop: ParamProp.TextController,
          ),
        ],
      ),
      const CleanMethod(
        name: "register",
        endPoint: "/register",
        response: "BaseResponse<UserModel?>",
        requestType: RequestType.Fields,
        isCache: true,
        methodType: MethodType.POST,
        parameters: [
          Param(
            name: 'fullName',
            key: "full_name",
            type: ParamType.Field,
            prop: ParamProp.TextController,
          ),
          Param(
            name: 'phone',
            type: ParamType.Field,
            prop: ParamProp.TextController,
          ),
          Param(
            name: 'email',
            type: ParamType.Field,
            prop: ParamProp.TextController,
          ),
          Param(
            name: 'password',
            type: ParamType.Field,
            prop: ParamProp.TextController,
          ),
          Param(
            name: 'id',
            type: ParamType.Query,
            prop: ParamProp.Set,
          ),
        ],
      ),
      const CleanMethod(
        name: "getAddresses",
        endPoint: "/getAddresses",
        response: "BaseResponse<List<AddressModel>?>",
        requestType: RequestType.Fields,
        isPaging: true,
        methodType: MethodType.GET,
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
          Param(
            name: 'userId',
            type: ParamType.Query,
            prop: ParamProp.Set,
          ),
        ],
      ),
      const CleanMethod(
        name: "getOTPs",
        endPoint: "/getOTPs",
        response: "BaseResponse<List<OtpModel>?>",
        requestType: RequestType.Fields,
        isPaging: true,
        methodType: MethodType.GET,
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
          Param(
            name: 'userId',
            type: ParamType.Query,
            prop: ParamProp.Set,
          ),
        ],
      ),
      const CleanMethod(
        name: "getOtp",
        endPoint: "/getOtp",
        response: "BaseResponse<List<OtpModel>?>",
        requestType: RequestType.Fields,
        isPaging: true,
        methodType: MethodType.GET,
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
          Param(
            name: 'userId',
            type: ParamType.Query,
            prop: ParamProp.Set,
          ),
        ],
      ),
    ];
  }
}
