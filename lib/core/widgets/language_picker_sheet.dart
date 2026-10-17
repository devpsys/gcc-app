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
        // No hand-rolled height cap here. AppSheet already bounds the body to
        // the space left after its chrome, and that space already accounts for
        // the keyboard — guessing a fraction of the screen instead overflowed
        // the sheet on tall devices and at large text scales. The scroll view
        // stays a direct child of the Padding: a Flexible here would sit
        // outside AppSheet's Flex and throw a ParentData error.
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: LanguageOptionRow(
                option: option,
                selected: option.id == _selectedId,
                currentLabel: l10n.authLanguageCurrent,
                unavailableReason: l10n.authLanguageUnavailable,
                onTap: () => _select(option),
              ),
            );
          },
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
