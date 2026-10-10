import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_breakpoints.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_neutral_button.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/home/domain/entities/theme_preference.dart';
import 'package:gcc_app/features/home/presentation/bloc/home_cubit.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({required this.themeMode, super.key});

  final AppThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.themeModeLabel,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        LayoutBuilder(
          builder: (context, constraints) {
            final stacked = constraints.maxWidth < AppBreakpoints.medium;
            final buttons = [
              for (final mode in AppThemeMode.values)
                _modeButton(context, l10n, mode),
            ];
            if (stacked) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var index = 0; index < buttons.length; index++) ...[
                    if (index > 0) const SizedBox(height: AppSpacing.xs),
                    buttons[index],
                  ],
                ],
              );
            }
            return Row(
              children: [
                for (var index = 0; index < buttons.length; index++) ...[
                  if (index > 0) const SizedBox(width: AppSpacing.xs),
                  Expanded(child: buttons[index]),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _modeButton(
    BuildContext context,
    AppLocalizations l10n,
    AppThemeMode mode,
  ) {
    final label = _label(l10n, mode);
    void onPressed() => _select(context, mode);
    if (mode == themeMode) {
      return AppPrimaryButton(label: label, onPressed: onPressed);
    }
    return AppNeutralButton(label: label, onPressed: onPressed);
  }

  void _select(BuildContext context, AppThemeMode mode) {
    context.read<HomeCubit>().setThemeMode(mode);
  }

  String _label(AppLocalizations l10n, AppThemeMode mode) {
    return switch (mode) {
      AppThemeMode.system => l10n.themeModeSystem,
      AppThemeMode.light => l10n.themeModeLight,
      AppThemeMode.dark => l10n.themeModeDark,
    };
  }
}
