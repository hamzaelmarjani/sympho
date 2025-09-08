import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  final deviceInfoPlugin = DeviceInfoPlugin();
  Future<Map<String, dynamic>> getDeviceInfo() async {
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
    return allInfo;
  }
}
