import 'package:clean_architecture_generator/clean_architecture_generator.dart';

@CleanArchitecture
class Home implements CleanArchitectureSetUp {
  @override
  List<CleanMethod> methods() {
    return [
      const CleanMethod(
        methodType: MethodType.GET,
        name: 'getGovernorates',
        endPoint: "/api/governates",
        response: "BaseResponse<List<GovernorateModel>?>",
        parameters: [],
      ),
      const CleanMethod(
        methodType: MethodType.GET,
        name: 'getResult',
        endPoint: "/api/result/{countryId}/{termId}",
        response: "BaseResponse<ResultModel?>",
        parameters: [
          Param(
            name: 'countryId',
            type: ParamType.Path,
            dataType: ParamDataType.int,
          ),
          Param(
            name: 'termId',
            type: ParamType.Path,
            dataType: ParamDataType.int,
            isRequired: false,
          ),
          Param(
            name: 'studentName',
            key: 'student_name',
            type: ParamType.Query,
            isRequired: false,
          ),
          Param(
            name: 'sittingNumber',
            key: 'sitting_number',
            type: ParamType.Query,
            isRequired: false,
          ),
        ],
      ),
      const CleanMethod(
        methodType: MethodType.GET,
        name: 'addFavorite',
        endPoint: "/api/favorites/{countryId}",
        response: "BaseResponse<int>",
        parameters: [
          Param(
            name: 'countryId',
            type: ParamType.Path,
            dataType: ParamDataType.int,
          ),
        ],
      ),
      const CleanMethod(
        name: 'updateUser',
        endPoint: "/api/update/user",
        response: "BaseResponse<DeviceSettingsModel?>",
        methodType: MethodType.PUT,
        parameters: [
          Param(
            name: 'firebaseToken',
            key: 'firebase_token',
            type: ParamType.Path,
            dataType: ParamDataType.int,
          ),
        ],
      ),
    ];
  }
}
