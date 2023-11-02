import 'package:clean_architecture_generator/clean_architecture_generator.dart';

@CleanArchitecture
class Home implements CleanArchitectureSetUp {
  @override
  List<CleanMethod> methods() {
    return [
      const CleanMethod(
        name: 'addComment',
        endPoint: 'sendCode',
        response: 'BaseResponse<DeviceSettingsModel?>',
        methodType: MethodType.POST,
        parameters: [
          Param(
            key: 'story_id',
            name: 'storyId',
            type: ParamType.Field,
          ),
          Param(
            name: 'content',
            type: ParamType.Field,
            prop: ParamProp.TextController,
          ),
        ],
      ),
      const CleanMethod(
        name: 'addComment2',
        endPoint: 'sendCode',
        response: 'BaseResponse<DeviceSettingsModel?>',
        methodType: MethodType.POST,
        parameters: [
          Param(
            key: 'story_id',
            name: 'storyId',
            type: ParamType.Field,
          ),
          Param(
            name: 'content',
            type: ParamType.Field,
            prop: ParamProp.TextController,
          ),
        ],
      ),
      const CleanMethod(
        name: 'addComment3',
        endPoint: 'sendCode',
        response: 'BaseResponse<DeviceSettingsModel?>',
        methodType: MethodType.POST,
        parameters: [
          Param(
            key: 'story_id',
            name: 'storyId',
            type: ParamType.Field,
          ),
          Param(
            name: 'content',
            type: ParamType.Field,
            prop: ParamProp.TextController,
          ),
        ],
      ),
      const CleanMethod(
        name: 'addComment4',
        endPoint: 'sendCode',
        response: 'BaseResponse<DeviceSettingsModel?>',
        methodType: MethodType.POST,
        parameters: [
          Param(
            key: 'story_id',
            name: 'storyId',
            type: ParamType.Field,
          ),
          Param(
            name: 'content',
            type: ParamType.Field,
            prop: ParamProp.TextController,
          ),
        ],
      ),
      const CleanMethod(
        name: 'addComment5',
        endPoint: 'sendCode',
        isCache: true,
        response: 'BaseResponse<DeviceSettingsModel?>',
        methodType: MethodType.POST,
        parameters: [
          Param(
            key: 'story_id',
            name: 'storyId',
            type: ParamType.Field,
          ),
          Param(
            name: 'content',
            type: ParamType.Field,
            prop: ParamProp.TextController,
          ),
        ],
      ),
      const CleanMethod(
        name: 'addComment6',
        endPoint: 'sendCode',
        isCache: true,
        response: 'BaseResponse<DeviceSettingsModel?>',
        methodType: MethodType.POST,
        parameters: [
          Param(
            key: 'story_id',
            name: 'storyId',
            type: ParamType.Field,
          ),
          Param(
            name: 'content',
            type: ParamType.Field,
            prop: ParamProp.TextController,
          ),
        ],
      ),
      const CleanMethod(
        name: 'addComment7',
        endPoint: 'sendCode',
        isCache: true,
        response: 'BaseResponse<DeviceSettingsModel?>',
        methodType: MethodType.POST,
        parameters: [
          Param(
            key: 'story_id',
            name: 'storyId',
            type: ParamType.Field,
          ),
          Param(
            name: 'content',
            type: ParamType.Field,
            prop: ParamProp.TextController,
          ),
        ],
      ),
    ];
  }
}
