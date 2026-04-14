import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/colors.dart';

class AppThemes {
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: VColor.primary,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: VColor.dark,
  );
}

class ThemeService extends GetxController {
  Rx<ThemeData> theme = AppThemes.light.obs;

  void toggleTheme() {
    if (theme.value.brightness == Brightness.light) {
      theme.value = AppThemes.dark;
    } else {
      theme.value = AppThemes.light;
    }
  }
}
