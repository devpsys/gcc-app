import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    required this.name,
    this.size = AppDimensions.navigationBarHeight,
    super.key,
  });

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final initials = _initials(name);
    return Semantics(
      label: name,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: scheme.primaryContainer,
          // The design draws a 1 px brand edge at 20% so the avatar reads as a
          // distinct surface on light backgrounds.
          border: Border.all(color: scheme.primary.withValues(alpha: 0.2)),
          shape: BoxShape.circle,
        ),
        child: Text(
          initials,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(color: scheme.primary, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  String _initials(String value) {
    final parts = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return '';
    }
    final first = parts.first.characters.first;
    if (parts.length == 1) {
      return first.toUpperCase();
    }
    return (first + parts[1].characters.first).toUpperCase();
  }
}
