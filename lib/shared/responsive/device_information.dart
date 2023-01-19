import 'package:flutter/cupertino.dart';

import 'device_type_enum.dart';

class DeviceInformation {

  late DeviceType deviceType;
  late final double localHeight;
  late final double localWidth;
  late final double screenHeight;
  late final double screenWidth;
  late final Orientation orientation;

  DeviceInformation({
    required this.deviceType,
    required this.localHeight,
    required this.localWidth,
    required this.screenHeight,
    required this.screenWidth,
    required this.orientation,
  });
}
