import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/widgets/responsive_content.dart';

class StartupFailurePage extends StatelessWidget {
  const StartupFailurePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveContent(
        child: Text(
          context.l10n.startupFailed,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
