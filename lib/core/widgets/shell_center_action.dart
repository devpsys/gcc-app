import 'package:flutter/widgets.dart';

class ShellCenterAction {
  const ShellCenterAction({
    required this.label,
    required this.icon,
    this.onPressed,
    this.disabledReason,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final String? disabledReason;
}
