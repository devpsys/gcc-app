import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';
import 'package:gcc_app/core/widgets/language_catalog.dart';
import 'package:gcc_app/core/widgets/language_option.dart';
import 'package:gcc_app/core/widgets/language_option_row.dart';

class LanguagePickerSheet extends StatefulWidget {
  const LanguagePickerSheet({required this.selectedId, super.key});

  final String selectedId;

  @override
  State<LanguagePickerSheet> createState() => _LanguagePickerSheetState();
}

class _LanguagePickerSheetState extends State<LanguagePickerSheet> {
  late String _selectedId = widget.selectedId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final options = gccLanguageOptions(l10n);

    return AppSheet(
      title: l10n.authLanguage,
      closeLabel: l10n.authClose,
      onClose: () => Navigator.of(context).pop(),
      footer: AppPrimaryButton(
        label: l10n.authSave,
        onPressed: _canSave
            ? () => Navigator.of(context).pop(_selectedId)
            : null,
        disabledReason: l10n.authLanguageUnavailable,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LimitedBox(
              maxHeight: MediaQuery.sizeOf(context).height * 0.45,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (final option in options) ...[
                      LanguageOptionRow(
                        option: option,
                        selected: option.id == _selectedId,
                        currentLabel: l10n.authLanguageCurrent,
                        unavailableReason: l10n.authLanguageUnavailable,
                        onTap: () => _select(option),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _canSave {
    return gccLanguageOptions(context.l10n)
        .any((option) => option.id == _selectedId && option.enabled);
  }

  void _select(LanguageOption option) {
    if (!option.enabled) {
      return;
    }
    setState(() => _selectedId = option.id);
  }
}

Future<String?> showAppLanguagePicker({
  required BuildContext context,
  required String selectedId,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    barrierColor: Theme.of(context).colorScheme.scrim,
    builder: (context) => LanguagePickerSheet(selectedId: selectedId),
  );
}
