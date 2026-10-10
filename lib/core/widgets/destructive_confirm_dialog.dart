import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_destructive_button.dart';
import 'package:gcc_app/core/widgets/app_neutral_button.dart';

class DestructiveConfirmDialog extends StatelessWidget {
  const DestructiveConfirmDialog({
    required this.title,
    required this.message,
    required this.safeLabel,
    required this.destructiveLabel,
    this.notice,
    super.key,
  });

  final String title;
  final String message;
  final String safeLabel;
  final String destructiveLabel;
  final String? notice;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final noticeText = notice;

    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.88,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.errorContainer,
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(
                    width: AppDimensions.noticeIcon,
                    height: AppDimensions.noticeIcon,
                    child: Icon(
                      Icons.warning_amber_rounded,
                      color: scheme.error,
                      size: AppDimensions.iconLg,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (noticeText != null) ...[
                const SizedBox(height: AppSpacing.md),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.errorContainer,
                    borderRadius: BorderRadius.circular(AppRadii.input),
                    border: Border.all(
                      color: context.semanticColors.dangerBorder,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Text(
                      noticeText,
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: scheme.error),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              Text(message, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: AppSpacing.xl),
              AppNeutralButton(
                label: safeLabel,
                onPressed: () => Navigator.of(context).pop(false),
              ),
              const SizedBox(height: AppSpacing.xs),
              AppDestructiveButton(
                label: destructiveLabel,
                filled: true,
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> showDestructiveConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String safeLabel,
  required String destructiveLabel,
  String? notice,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    barrierColor: Theme.of(context).colorScheme.scrim,
    builder: (dialogContext) {
      return DestructiveConfirmDialog(
        title: title,
        message: message,
        safeLabel: safeLabel,
        destructiveLabel: destructiveLabel,
        notice: notice,
      );
    },
  );
  return confirmed ?? false;
}
