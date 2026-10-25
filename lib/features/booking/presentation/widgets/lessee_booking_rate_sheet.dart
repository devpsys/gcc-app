import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';

Future<int?> showLesseeBookingRateSheet({
  required BuildContext context,
  required String title,
  int? initialRating,
}) {
  return showAppSheet<int>(
    context: context,
    title: context.l10n.bookingsDetailRateRental,
    closeLabel: context.l10n.authClose,
    child: LesseeBookingRateSheet(
      bookingTitle: title,
      initialRating: initialRating ?? 0,
    ),
  );
}

class LesseeBookingRateSheet extends StatefulWidget {
  const LesseeBookingRateSheet({
    required this.bookingTitle,
    required this.initialRating,
    super.key,
  });

  final String bookingTitle;
  final int initialRating;

  @override
  State<LesseeBookingRateSheet> createState() => _LesseeBookingRateSheetState();
}

class _LesseeBookingRateSheetState extends State<LesseeBookingRateSheet> {
  late int _rating = widget.initialRating.clamp(0, 5);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
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
          Text(
            widget.bookingTitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.muted,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var star = 1; star <= 5; star++)
                IconButton(
                  tooltip: l10n.bookingsRateStar(star),
                  onPressed: () => setState(() => _rating = star),
                  icon: Icon(
                    star <= _rating ? Icons.star : Icons.star_border,
                    size: AppDimensions.iconLg,
                    color: star <= _rating ? colors.warning : colors.muted,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppPrimaryButton(
            label: l10n.bookingsRateSubmit,
            onPressed: _rating > 0
                ? () => Navigator.of(context).pop(_rating)
                : null,
            disabledReason: _rating > 0 ? null : l10n.bookingsRateSubmitHint,
          ),
        ],
      ),
    );
  }
}
