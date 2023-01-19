import 'package:flutter/cupertino.dart';

import 'device_type_enum.dart';

DeviceType getDeviceType(MediaQueryData deviceData) 
{
  double width = deviceData.size.width;
  if (Orientation.landscape == deviceData.orientation) {
    width = deviceData.size.height;
  }
  if (width >= 960) {
    return DeviceType.desktop;
  } else if (width >= 600) {
    return DeviceType.tablet;
  } else {
    return DeviceType.mobile;
  }
}
