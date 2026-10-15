import 'package:flutter/widgets.dart';

class ShellDestination {
  const ShellDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.location,
    this.available = true,
    this.unavailableReason,
    this.badgeCount = 0,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String location;
  final bool available;
  final String? unavailableReason;
  final int badgeCount;
}
