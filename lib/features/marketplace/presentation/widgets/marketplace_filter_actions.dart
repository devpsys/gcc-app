import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_state.dart';

class MarketplaceFilterActions extends StatelessWidget {
  const MarketplaceFilterActions({required this.onClose, super.key});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketplaceBrowseCubit, MarketplaceBrowseState>(
      builder: (context, state) {
        final count = state is MarketplaceBrowseReady
            ? state.visible.length
            : 0;
        final l10n = context.l10n;
        return Row(
          children: [
            TextButton(
              onPressed: () =>
                  context.read<MarketplaceBrowseCubit>().clearFilters(),
              child: Text(l10n.marketplaceReset),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppPrimaryButton(
                label: l10n.marketplaceShowResults(count),
                onPressed: onClose,
              ),
            ),
          ],
        );
      },
    );
  }
}
