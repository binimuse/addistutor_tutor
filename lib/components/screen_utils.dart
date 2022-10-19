import 'package:flutter/material.dart';

class ScreenUtil {
  static DeviceType getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    return data.size.shortestSide < 600 ? DeviceType.phone : DeviceType.tablet;
  }

  bool isPhone() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    DeviceType deviceType =
        data.size.shortestSide < 600 ? DeviceType.phone : DeviceType.tablet;
    if (deviceType == DeviceType.tablet) {
      return false;
    }

    return true;
  }
}

enum DeviceType {
  phone,
  tablet,
}
