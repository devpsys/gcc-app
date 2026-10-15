import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';

class DashboardWordmark extends StatelessWidget {
  const DashboardWordmark({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Text(
      context.l10n.appTitle,
      style: Theme.of(context).textTheme.headlineSmall
          ?.copyWith(color: scheme.primary, fontWeight: FontWeight.w700),
    );
  }
}
