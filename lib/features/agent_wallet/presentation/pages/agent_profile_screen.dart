import 'package:flutter/material.dart';

import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/language_picker_sheet.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/agent_profile.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/storage_category.dart';
import 'package:gcc_app/features/agent_wallet/presentation/gateway/wallet_gateway.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/profile_page.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/agent_shell.dart';
import 'package:go_router/go_router.dart';

/// The routed agent profile.
///
/// Loads the agent and their storage breakdown, then renders [ProfilePage]
/// inside [AgentShell].
///
/// The profile is not one of the five agent tabs — the designs reach it from the
/// Today header — so no tab is highlighted. It still carries the navigation,
/// because a settings screen with no way back out is a dead end.
class AgentProfileScreen extends StatefulWidget {
  const AgentProfileScreen({super.key});

  @override
  State<AgentProfileScreen> createState() => _AgentProfileScreenState();
}

class _AgentProfileScreenState extends State<AgentProfileScreen> {
  Future<AgentProfile?>? _profile;
  Future<List<StorageCategory>>? _storage;

  @override
  void initState() {
    super.initState();
    final gateway = getIt<WalletGateway>();
    _profile = gateway.loadProfile();
    _storage = gateway.loadStorageCategories();
  }

  @override
  Widget build(BuildContext context) {
    return AgentShell(
      selectedLocation: RoutePaths.agentProfile,
      title: context.l10n.profileTitle,
      child: Scaffold(
        body: FutureBuilder<AgentProfile?>(
          future: _profile,
          builder: (context, snapshot) {
            final profile = snapshot.data;
            if (profile == null) {
              if (!snapshot.hasData) {
                return const Center(child: AppLoadingIndicator());
              }
              // No profile on this device yet. Say so rather than rendering an
              // empty settings page that looks like a broken one.
              return const ProfileUnavailable();
            }
            return FutureBuilder<List<StorageCategory>>(
              future: _storage,
              builder: (context, storage) => ProfilePage(
                profile: profile,
                storageCategories: storage.data ?? const [],
                onOpenLanguage: () => showAppLanguagePicker(
                  context: context,
                  selectedId: 'english',
                ),
                onOpenNotifications: () =>
                    GoRouter.maybeOf(context)
                        ?.push(RoutePaths.agentNotifications),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Shown when the app holds no profile for this device.
class ProfileUnavailable extends StatelessWidget {
  const ProfileUnavailable({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_off_outlined,
              size: AppDimensions.emptyStateIcon,
              color: scheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.profileUnavailableTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.profileUnavailableBody,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
