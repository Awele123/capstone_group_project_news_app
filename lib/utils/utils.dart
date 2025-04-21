import 'package:flutter/material.dart';

class Utils {
  static CustomDeviceType getDeviceType() {
    final data = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.first,
    );
    return data.size.shortestSide < 500
        ? CustomDeviceType.phone
        : CustomDeviceType.tablet;
  }

  static double textSize(double size) {
    if (getDeviceType() == CustomDeviceType.tablet) {
      return size - 2;
    }
    return size;
  }
}

enum CustomDeviceType { phone, tablet }
