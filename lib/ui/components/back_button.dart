import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/colors.dart';

class VBackButton extends StatelessWidget {
  const VBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      child: const Icon(
        Icons.arrow_back,
        color: VColor.dark,
      ),
    );
  }
}
