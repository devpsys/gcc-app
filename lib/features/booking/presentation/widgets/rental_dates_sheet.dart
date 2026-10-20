import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';
import 'package:gcc_app/features/booking/domain/rental_days.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_request_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_request_state.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_date_labels.dart';

/// Half-detent dates sheet body. Invalid return dates show corrections.
class RentalDatesSheet extends StatelessWidget {
  const RentalDatesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RentalRequestCubit, RentalRequestState>(
      builder: (context, state) {
        if (state is! RentalRequestReady) {
          return const SizedBox.shrink();
        }
        final l10n = context.l10n;
        final request = state.request;
        final valid = request.datesValid;
        final days = rentalDays(request.from, request.to);
        final cubit = context.read<RentalRequestCubit>();
        final colors = context.semanticColors;
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            if (!valid) ...[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.dangerContainer,
                  borderRadius: BorderRadius.circular(AppRadii.card),
                  border: Border.all(
                    color: colors.danger.withValues(alpha: 0.4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: colors.danger,
                        size: AppDimensions.iconMd,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          l10n.rentalDatesInvalid,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: colors.danger),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            RentalDateRow(
              label: l10n.rentalFrom,
              value: rentalDateTimeLabel(request.from),
              invalid: false,
              onTap: () => _pick(
                context,
                initial: request.from,
                onPicked: cubit.setFrom,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            RentalDateRow(
              label: l10n.rentalTo,
              value: rentalDateTimeLabel(request.to),
              invalid: !valid,
              hint: valid
                  ? null
                  : l10n.rentalChooseAfter(rentalDateTimeLabel(request.from)),
              onTap: () =>
                  _pick(context, initial: request.to, onPicked: cubit.setTo),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              valid ? l10n.rentalDuration(days) : l10n.rentalDurationInvalid,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: valid ? null : colors.danger),
            ),
            if (!valid) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.rentalQuickCorrections,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  ActionChip(
                    label: Text(l10n.rentalPlus1Day),
                    onPressed: () => cubit.addDaysToReturn(1),
                  ),
                  ActionChip(
                    label: Text(l10n.rentalPlus2Days),
                    onPressed: () => cubit.addDaysToReturn(2),
                  ),
                  ActionChip(
                    label: Text(l10n.rentalPlus3Days),
                    onPressed: () => cubit.addDaysToReturn(3),
                  ),
                  ActionChip(
                    label: Text(l10n.rentalPlus1Week),
                    onPressed: () => cubit.addDaysToReturn(7),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }

  Future<void> _pick(
    BuildContext context, {
    required DateTime initial,
    required ValueChanged<DateTime> onPicked,
  }) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2026, 1, 1),
      lastDate: DateTime(2027, 12, 31),
    );
    if (date == null || !context.mounted) {
      return;
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null || !context.mounted) {
      return;
    }
    onPicked(DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }
}

class RentalDateRow extends StatelessWidget {
  const RentalDateRow({
    required this.label,
    required this.value,
    required this.invalid,
    required this.onTap,
    this.hint,
    super.key,
  });

  final String label;
  final String value;
  final bool invalid;
  final String? hint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.card),
        side: BorderSide(
          color: invalid ? colors.danger : colors.border,
          width: invalid
              ? AppDimensions.emphasisBorderWidth
              : AppDimensions.borderWidth,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppDimensions.minTouchTarget + AppSpacing.xs,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium
                      ?.copyWith(color: colors.muted),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: invalid ? colors.danger : null,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (hint != null)
                  Text(
                    hint!,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: colors.danger),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RentalDatesActions extends StatelessWidget {
  const RentalDatesActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RentalRequestCubit, RentalRequestState>(
      builder: (context, state) {
        final valid = state is RentalRequestReady && state.request.datesValid;
        final l10n = context.l10n;
        return AppPrimaryButton(
          label: l10n.rentalReview,
          onPressed: valid ? () => Navigator.of(context).pop(true) : null,
          disabledReason: valid ? null : l10n.rentalChooseValidFirst,
        );
      },
    );
  }
}

/// Opens the dates sheet. Returns true when the lessee taps Review.
Future<bool> showRentalDatesSheet({
  required BuildContext context,
  required RentalRequestCubit cubit,
}) async {
  final l10n = context.l10n;
  final reviewed = await showAppSheet<bool>(
    context: context,
    title: l10n.rentalWhenTitle,
    closeLabel: l10n.rentalCloseDates,
    child: BlocProvider.value(value: cubit, child: const RentalDatesSheet()),
    footer: BlocProvider.value(value: cubit, child: const RentalDatesActions()),
  );
  return reviewed ?? false;
}
