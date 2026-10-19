import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_period.dart';

class WalletPeriodBar extends StatelessWidget {
  const WalletPeriodBar({
    required this.selected,
    required this.labels,
    required this.onSelected,
    super.key,
  });

  final VendorWalletPeriod selected;
  final Map<VendorWalletPeriod, String> labels;
  final ValueChanged<VendorWalletPeriod> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxs),
        child: Row(
          children: [
            for (final period in VendorWalletPeriod.values)
              Expanded(
                child: _choice(
                  context,
                  period,
                  labels[period] ?? '',
                  period == selected,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _choice(
    BuildContext context,
    VendorWalletPeriod period,
    String label,
    bool selected,
  ) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: selected ? scheme.primary : scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(AppRadii.button),
      child: InkWell(
        onTap: () => onSelected(period),
        borderRadius: BorderRadius.circular(AppRadii.button),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppDimensions.minTouchTarget,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: selected ? scheme.onPrimary : scheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
