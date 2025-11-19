import 'package:toastification/toastification.dart';

import '../../configs/colors.dart';
import 'texts.dart';

abstract class VToast {
  static void success(String message) {
    toastification.show(
      title: VText(message, color: VColor.white),
      type: .success,
      style: .fillColored,
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: true,
    );
  }

  static void error(String message) {
    toastification.show(
      title: VText(message, color: VColor.white),
      type: .error,
      style: .fillColored,
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: true,
    );
  }
}
