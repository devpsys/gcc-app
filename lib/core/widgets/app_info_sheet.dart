import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';

/// Local sheet for actions that are not connected to a backend yet.
Future<void> showAppInfoSheet({
  required BuildContext context,
  required String title,
  required String body,
}) {
  return showAppSheet<void>(
    context: context,
    title: title,
    closeLabel: context.l10n.authClose,
    child: AppInfoSheet(body: body),
  );
}

class AppInfoSheet extends StatelessWidget {
  const AppInfoSheet({required this.body, super.key});

  final String body;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(body, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.md),
          AppPrimaryButton(
            label: l10n.authClose,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
