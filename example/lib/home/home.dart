import 'package:clean_architecture_generator/clean_architecture_generator.dart';

@TDDCleanArchitecture
class Home implements CleanArchitectureSetUp {
  @override
  List<CleanMethod> methods() {
    return [
      const CleanMethod(
        name: 'updateUser',
        response: "DeviceSettingsModel",
        isCache: true,
      ),
    ];
  }
}
