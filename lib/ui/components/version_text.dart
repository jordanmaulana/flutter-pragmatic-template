import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'texts.dart';

/// Shows version text to indicate app version written in pubspec.yaml
class VVersionText extends StatefulWidget {
  final bool onlyVersion;

  const VVersionText({this.onlyVersion = false, super.key});

  @override
  State<VVersionText> createState() => _VVersionTextState();
}

class _VVersionTextState extends State<VVersionText> {
  PackageInfo? info;

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String version = 'Version ${info?.version ?? ''}';
    return VText(version, align: .center);
  }

  Future<void> getInfo() async {
    info = await PackageInfo.fromPlatform();
    if (mounted) setState(() {});
  }
}
