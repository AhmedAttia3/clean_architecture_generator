class DeviceSettingsEntity {
  final String deviceId;
  final String deviceType;
  final String firebaseToken;

  const DeviceSettingsEntity({
    required this.deviceId,
    required this.deviceType,
    required this.firebaseToken,
  });
}
