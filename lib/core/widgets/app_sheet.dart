import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class AppSheet extends StatelessWidget {
  const AppSheet({
    required this.title,
    required this.child,
    this.subtitle,
    this.closeLabel,
    this.onClose,
    this.footer,
    super.key,
  });

  final String title;

  /// The sheet body.
  ///
  /// Given at most the height left after the handle, header and footer, so a
  /// tall body is clamped rather than overflowing the sheet. A body that can
  /// scroll should scroll itself; one that cannot will be clipped at the
  /// bottom rather than painting over the footer.
  final Widget child;
  final String? subtitle;
  final String? closeLabel;
  final VoidCallback? onClose;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final subtitleText = subtitle;
    final footerWidget = footer;
    final close = closeLabel;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.outline,
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
              child: const SizedBox(
                width: AppDimensions.sheetHandleWidth,
                height: AppDimensions.sheetHandleHeight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.xs,
              AppSpacing.xs,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (subtitleText != null)
                        Text(
                          subtitleText,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
                if (close != null)
                  IconButton(
                    tooltip: close,
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                  ),
              ],
            ),
          ),
          Flexible(fit: FlexFit.loose, child: child),
          if (footerWidget != null)
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: context.semanticColors.border),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: footerWidget,
              ),
            ),
        ],
      ),
    );
  }
}

Future<T?> showAppSheet<T>({
  required BuildContext context,
  required String title,
  required Widget child,
  String? subtitle,
  String? closeLabel,
  Widget? footer,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    barrierColor: Theme.of(context).colorScheme.scrim,
    builder: (sheetContext) {
      return AppSheet(
        title: title,
        subtitle: subtitle,
        closeLabel: closeLabel,
        onClose: () => Navigator.of(sheetContext).pop(),
        footer: footer,
        child: child,
      );
    },
  );
}
