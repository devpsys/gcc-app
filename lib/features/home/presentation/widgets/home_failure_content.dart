import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/responsive_content.dart';
import 'package:gcc_app/features/home/presentation/bloc/home_cubit.dart';

class HomeFailureContent extends StatelessWidget {
  const HomeFailureContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ResponsiveContent(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.homeLoadFailed,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: () => context.read<HomeCubit>().load(),
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }
}
