import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'texts.dart';

/// Shows version text to indicate app version written in pubspec.yaml
class VersionText extends StatefulWidget {
  final bool onlyVersion;

  const VersionText({this.onlyVersion = false, super.key});

  @override
  VersionTextState createState() => VersionTextState();
}

class VersionTextState extends State<VersionText> {
  PackageInfo? info;

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String version = 'Version ${info?.version ?? ''}';
    return VText(
      version,
      align: TextAlign.center,
    );
  }

  Future<void> getInfo() async {
    info = await PackageInfo.fromPlatform();
    if (mounted) setState(() {});
  }
}
