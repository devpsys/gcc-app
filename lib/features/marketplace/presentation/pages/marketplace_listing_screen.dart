import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/widgets/app_info_sheet.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_listing_pane.dart';

class MarketplaceListingScreen extends StatelessWidget {
  const MarketplaceListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboardBrowseEquipment),
        actions: [
          IconButton(
            tooltip: l10n.marketplaceShare,
            onPressed: () => showAppInfoSheet(
              context: context,
              title: l10n.marketplaceShare,
              body: l10n.marketplaceShareBody,
            ),
            icon: const Icon(Icons.ios_share_outlined),
          ),
          IconButton(
            tooltip: l10n.marketplaceMore,
            onPressed: () => showAppInfoSheet(
              context: context,
              title: l10n.marketplaceMore,
              body: l10n.marketplaceMoreBody,
            ),
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: const MarketplaceListingPane(),
    );
  }
}
