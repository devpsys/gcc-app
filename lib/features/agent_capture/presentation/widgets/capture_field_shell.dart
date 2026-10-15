import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';

class CaptureFieldShell extends StatelessWidget {
  const CaptureFieldShell({
    required this.child,
    required this.focused,
    this.error = false,
    this.enabled = true,
    this.fill,
    super.key,
  });

  final Widget child;
  final bool focused;
  final bool error;
  final bool enabled;
  final Color? fill;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final borderColor = error
        ? scheme.error
        : focused
        ? scheme.primary
        : enabled
        ? scheme.outline
        : colors.border;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: fill ?? scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.input),
        border: Border.all(color: borderColor),
        boxShadow: focused
            ? [
                BoxShadow(
                  color: error ? colors.dangerBorder : scheme.primaryContainer,
                  spreadRadius: AppDimensions.borderWidth * 2,
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
