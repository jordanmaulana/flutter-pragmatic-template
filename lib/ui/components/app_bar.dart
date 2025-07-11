import 'package:flutter/material.dart';

import 'back_button.dart';
import 'texts.dart';

/// Used for custom appbar.
/// E.g: appbar that has transparent background of some gradient color.
class StandardAppbar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final bool includeBackButton;
  final String? title;
  const StandardAppbar({
    super.key,
    this.actions,
    this.includeBackButton = true,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title == null ? null : VText(title),
      automaticallyImplyLeading: false,
      leading: includeBackButton ? const VBackButton() : null,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
