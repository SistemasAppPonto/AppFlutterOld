import 'package:android_multiple_identifier/android_multiple_identifier.dart';
import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;

class DeviceInfo {
  static DeviceInfo _instance;

  String imei;
  String serial;
  String androidID;
  String modelo;

  DeviceInfo._() {}

  static DeviceInfo getInstance() {
    return _instance = _instance ?? DeviceInfo._();
  }

  Future<void> getDeviceSerialNumber() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    print(deviceInfo);
    print(Platform.operatingSystem);

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      this.modelo = androidInfo.model; //
      print(androidInfo.id); //
      print(androidInfo.display); //
      print(androidInfo.hardware); //
      print(androidInfo.version.previewSdkInt); //
      print(androidInfo.version.release); //
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.machine}');
    }

    // Ask user permission
    await AndroidMultipleIdentifier.requestPermission();
    // Get device information async
    Map idMap = await AndroidMultipleIdentifier.idMap;
    print("idMap");
    print(idMap);

    this.imei = idMap["imei"];
    this.serial = idMap["serial"];
    this.androidID = idMap["androidId"];
  }

  @override
  String toString() {
    return 'DeviceInfo{imei: $imei, serial: $serial, androidID: $androidID}';
  }
}
