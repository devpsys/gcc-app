import 'package:gcc_app/features/agent_wallet/presentation/bloc/bounty_status.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

/// Whether a status screen is showing the rejected frame.
bool isRejected(BountyStatus status) => status == BountyStatus.rejected;

/// The label the designs use for each frame's headline.
String headlineFor(AppLocalizations l10n, BountyStatus status) =>
    switch (status) {
      BountyStatus.awaitingVerification => l10n.bountyAwaitingHeadline,
      BountyStatus.verified => l10n.bountyVerifiedHeadline,
      BountyStatus.rejected => l10n.bountyRejectedHeadline,
    };
