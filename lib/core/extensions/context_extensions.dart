import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_semantic_colors.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

extension AppContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  AppSemanticColors get semanticColors {
    final colors = Theme.of(this).extension<AppSemanticColors>();
    assert(colors != null, 'AppSemanticColors is missing from ThemeData.');
    return colors!;
  }
}
