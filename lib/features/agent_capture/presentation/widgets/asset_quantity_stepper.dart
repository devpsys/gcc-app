import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_step_button.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_field_shell.dart';

/// Minus / value / plus control for the asset's quantity.
///
/// The design draws a 52 px row with two square buttons around a centred
/// tabular value. The buttons are kept a full 48 px tall here: inside a 52 px
/// row the visual difference is a couple of pixels, and the larger target is
/// the one that matters on a phone held one-handed.
class AssetQuantityStepper extends StatelessWidget {
  const AssetQuantityStepper({
    required this.quantity,
    required this.onChanged,
    super.key,
  });

  final int quantity;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return CaptureFieldShell(
      focused: false,
      child: SizedBox(
        height: AppDimensions.inputHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: Row(
            children: [
              AssetStepButton(
                icon: Icons.remove,
                label: l10n.captureAssetDecrease,
                // Never below one — an asset with no quantity is not a capture.
                onTap: quantity > 1 ? () => onChanged(quantity - 1) : null,
              ),
              Expanded(
                child: Semantics(
                  label: l10n.captureAssetQuantityValue(quantity),
                  child: ExcludeSemantics(
                    child: Text(
                      '$quantity',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.tabular(
                        Theme.of(context).textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              AssetStepButton(
                icon: Icons.add,
                label: l10n.captureAssetIncrease,
                onTap: () => onChanged(quantity + 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
