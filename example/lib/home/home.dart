import 'package:clean_architecture_generator/clean_architecture_generator.dart';

@CleanArchitecture
class Home implements CleanArchitectureSetUp {
  @override
  List<CleanMethod> methods() {
    return [
      const CleanMethod(
        name: 'updateUser',
        response: "DeviceSettingsModel",
        isCache: true,
      ),
      const CleanMethod(
        name: 'updateUser2',
        response: "DeviceSettingsModel",
        isCache: true,
      ),
    ];
  }
}
