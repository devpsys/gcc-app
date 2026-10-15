import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:gcc_app/features/dashboard/presentation/pages/agent_today_page.dart';
import 'package:gcc_app/features/dashboard/presentation/pages/lessee_dashboard_page.dart';
import 'package:gcc_app/features/dashboard/presentation/pages/vendor_dashboard_page.dart';

class DashboardRoleSwitcher extends StatelessWidget {
  const DashboardRoleSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      buildWhen: (previous, current) => previous.role != current.role,
      builder: (context, state) {
        return switch (state.role) {
          DashboardRole.vendor => const VendorDashboardPage(),
          DashboardRole.agent => const AgentTodayPage(),
          DashboardRole.lessee => const LesseeDashboardPage(),
        };
      },
    );
  }
}
