import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/responsive_content.dart';
import 'package:gcc_app/features/home/presentation/bloc/home_cubit.dart';

class HomeFailureContent extends StatelessWidget {
  const HomeFailureContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ResponsiveContent(
      child: AppEmptyState(
        icon: Icons.error_outline,
        title: l10n.homeLoadFailed,
        actionLabel: l10n.retry,
        onAction: () => context.read<HomeCubit>().load(),
      ),
    );
  }
}
