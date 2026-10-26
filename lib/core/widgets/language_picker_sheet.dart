import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/language_catalog.dart';
import 'package:gcc_app/core/widgets/language_option.dart';
import 'package:gcc_app/core/widgets/language_picker_option_row.dart';

/// Full-height orthography sheet (MOB-AUTH-UNIFIED Frame 04).
class LanguagePickerSheet extends StatefulWidget {
  const LanguagePickerSheet({required this.selectedId, super.key});

  final String selectedId;

  @override
  State<LanguagePickerSheet> createState() => _LanguagePickerSheetState();
}

class _LanguagePickerSheetState extends State<LanguagePickerSheet> {
  late String _selectedId = widget.selectedId;
  var _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final options = gccLanguageOptions(l10n).where((option) {
      if (_query.trim().isEmpty) {
        return true;
      }
      final q = _query.trim().toLowerCase();
      return option.englishName.toLowerCase().contains(q) ||
          option.nativeName.toLowerCase().contains(q) ||
          option.sample.toLowerCase().contains(q);
    }).toList();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.94,
          child: Material(
            color: scheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppRadii.sheet),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: AppSpacing.xs,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        tooltip: l10n.authClose,
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                      Expanded(
                        child: Text(
                          l10n.authSelectLanguage,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      TextButton(
                        onPressed: _canSave
                            ? () => Navigator.of(context).pop(_selectedId)
                            : null,
                        child: Text(
                          l10n.authDone,
                          style: TextStyle(
                            color: scheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.sm,
                    AppSpacing.md,
                    AppSpacing.xs,
                  ),
                  child: TextField(
                    onChanged: (value) => setState(() => _query = value),
                    decoration: InputDecoration(
                      hintText: l10n.authSearchLanguagesHint,
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: scheme.surfaceContainerHighest.withValues(
                        alpha: 0.55,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.button),
                        borderSide: BorderSide(color: colors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.button),
                        borderSide: BorderSide(color: colors.border),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                    itemCount: options.length,
                    separatorBuilder: (_, _) => Divider(
                      height: 1,
                      color: colors.border,
                    ),
                    itemBuilder: (context, index) {
                      final option = options[index];
                      final selected = option.id == _selectedId;
                      return LanguagePickerOptionRow(
                        option: option,
                        selected: selected,
                        activeLabel: l10n.authLanguageActive,
                        unavailableReason: l10n.authLanguageUnavailable,
                        onTap: () => _select(option),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(AppRadii.button),
                      border: Border.all(color: colors.border),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.verified_outlined,
                            size: AppDimensions.iconSm,
                            color: scheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              l10n.authLanguageBoardNote,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.dashboardActionUnavailable),
                            ),
                          );
                        },
                        child: Text(
                          l10n.authReportTranslation,
                          style: TextStyle(
                            color: scheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      AppPrimaryButton(
                        label: l10n.authDoneSavePreference,
                        onPressed: _canSave
                            ? () => Navigator.of(context).pop(_selectedId)
                            : null,
                        disabledReason: l10n.authLanguageUnavailable,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get _canSave {
    return gccLanguageOptions(context.l10n).any(
      (option) => option.id == _selectedId && option.enabled,
    );
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
    backgroundColor: Theme.of(context).colorScheme.scrim,
    barrierColor: Theme.of(context).colorScheme.scrim,
    builder: (context) => LanguagePickerSheet(selectedId: selectedId),
  );
}
