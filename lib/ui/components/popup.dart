import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../configs/colors.dart';
import 'buttons.dart';
import 'loadings.dart';
import 'texts.dart';

class VPopup {
  VPopup._();

  /// Standardized loading widget.
  /// Shown when calling POST / UPDATE API.
  static void loading({bool dismissable = true}) {
    Get.dialog(
      const VLoading(),
      barrierDismissible: dismissable,
    );
  }

  /// Pops the loading indicator
  static void pop() {
    Get.back();
  }

  /// Standardized error popup
  static Future<void> error(String message, {title, Function? callback}) async {
    Get.dialog(
      Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        backgroundColor: VColor.scaffoldBg,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              VText(
                title ?? 'Error',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: VText(message, align: TextAlign.center),
              ),
              const SizedBox(height: 20.0),
              const Divider(
                thickness: 0.5,
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PrimaryButton(
                  'OK',
                  onTap: () {
                    Get.back();
                    if (callback != null) callback();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Standardized warning popup.
  /// Used when user does actions like deleting data or logout.
  static void proceedWarning(
      {required String title,
      required String message,
      required Function() callback}) {
    Get.dialog(
      Dialog(
        backgroundColor: VColor.scaffoldBg,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  VText(title, fontSize: 18.0, fontWeight: FontWeight.w500),
                  const SizedBox(height: 16.0),
                  VText(message, fontSize: 16.0),
                  const Divider(thickness: 1.0, height: 40.0),
                  PrimaryButton(
                    'OK',
                    onTap: callback,
                  )
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close, color: VColor.primary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
