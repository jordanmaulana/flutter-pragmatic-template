import 'package:flutter/material.dart';

import 'texts.dart';

/// Standardized error widget.
class VError extends StatelessWidget {
  final String errorMsg;

  const VError(this.errorMsg, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const .all(16.0),
        child: VText(errorMsg, align: .center),
      ),
    );
  }
}

/// Standardized empty data placeholder widget.
class NoData extends StatelessWidget {
  final String? text;

  const NoData({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return VText(text ?? 'Tidak ada data', align: .center);
  }
}
