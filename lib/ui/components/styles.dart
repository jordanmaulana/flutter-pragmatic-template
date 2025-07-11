import 'package:flutter/material.dart';

import '../../configs/colors.dart';

abstract class VStyle {
  /// Box shadow with rounded corner
  static BoxDecoration boxShadow({
    Color color = VColor.white,
    double radius = 8.0,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: shadow(),
    );
  }

  /// Outline & shadow with rounded corner
  static BoxDecoration boxShadowOutline({
    Color color = VColor.white,
    double radius = 8.0,
    Color borderColor = Colors.grey,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor),
      boxShadow: shadow(),
    );
  }

  /// Add shadow to container
  static List<BoxShadow> shadow() {
    return const [BoxShadow(blurRadius: 8.0, color: Colors.black12)];
  }

  /// Rounded corner
  static BoxDecoration corner({
    double radius = 12.0,
    Color? color,
  }) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius), color: color);
  }
}
