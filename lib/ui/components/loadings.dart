import 'package:flutter/material.dart';

import '../../configs/colors.dart';

/// Standardized loading widget.
class VLoading extends StatelessWidget {
  final Color? color;

  const VLoading({this.color = VColor.accent, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: color));
  }
}

/// Standardized loading widget for next page loading.
/// Next page loading is shown when list widget scrolled to the bottom of the list.
class NextPageLoading extends StatelessWidget {
  final double? progress;
  const NextPageLoading({this.progress, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16.0,
      left: 0.0,
      right: 0.0,
      child: LinearProgressIndicator(
        color: VColor.primary,
        value: progress,
      ),
    );
  }
}
