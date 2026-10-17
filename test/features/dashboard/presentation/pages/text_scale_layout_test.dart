import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_auth_cubit.dart';
import 'package:gcc_app/features/auth/presentation/pages/agent_otp_page.dart';
import 'package:gcc_app/features/auth/presentation/pages/agent_sign_in_page.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/gateway/mock_dashboard_gateway.dart';
import 'package:gcc_app/features/dashboard/presentation/pages/agent_today_page.dart';
import 'package:gcc_app/features/dashboard/presentation/pages/lessee_dashboard_page.dart';
import 'package:gcc_app/features/dashboard/presentation/pages/vendor_dashboard_page.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:gcc_app/features/onboarding/presentation/pages/onboarding_language_page.dart';
import 'package:gcc_app/features/onboarding/presentation/pages/onboarding_role_page.dart';
import 'package:gcc_app/features/onboarding/presentation/pages/onboarding_sign_in_page.dart';

import '../../../../helpers/pump_app.dart';
import '../../../auth/fake_agent_auth_gateway.dart';
import '../../../onboarding/fake_onboarding_gateway.dart';

void main() {
  const scales = [1.3, 2.0];
  const sizes = [Size(320, 640), Size(360, 800)];

  for (final scale in scales) {
    for (final size in sizes) {
      final label = '${size.width.toInt()}×${size.height.toInt()} at $scale';

      testWidgets('language page lays out at $label', (tester) async {
        await _pump(
          tester,
          size: size,
          scale: scale,
          child: BlocProvider(
            create: (_) => OnboardingCubit(FakeOnboardingGateway()),
            child: const OnboardingLanguagePage(),
          ),
        );
      });

      testWidgets('role page lays out at $label', (tester) async {
        await _pump(
          tester,
          size: size,
          scale: scale,
          child: BlocProvider(
            create: (_) => OnboardingCubit(FakeOnboardingGateway()),
            child: const OnboardingRolePage(),
          ),
        );
      });

      testWidgets('phone page lays out at $label', (tester) async {
        await _pump(
          tester,
          size: size,
          scale: scale,
          child: BlocProvider(
            create: (_) => OnboardingCubit(FakeOnboardingGateway()),
            child: const OnboardingSignInPage(),
          ),
        );
      });

      testWidgets('agent sign-in lays out at $label', (tester) async {
        await _pump(
          tester,
          size: size,
          scale: scale,
          child: BlocProvider(
            create: (_) => AgentAuthCubit(FakeAgentAuthGateway()),
            child: const AgentSignInPage(),
          ),
        );
      });

      testWidgets('agent code page lays out at $label', (tester) async {
        await _pump(
          tester,
          size: size,
          scale: scale,
          child: BlocProvider(
            create: (_) => AgentAuthCubit(FakeAgentAuthGateway()),
            child: const AgentOtpPage(),
          ),
        );
      });

      testWidgets('lessee home lays out at $label', (tester) async {
        final cubit = DashboardCubit(
          const MockDashboardGateway(),
          role: DashboardRole.lessee,
        );
        await cubit.load();
        await _pump(
          tester,
          size: size,
          scale: scale,
          child: BlocProvider.value(
            value: cubit,
            child: const LesseeDashboardPage(),
          ),
        );
      });

      testWidgets('vendor home lays out at $label', (tester) async {
        final cubit = DashboardCubit(
          const MockDashboardGateway(),
          role: DashboardRole.vendor,
        );
        await cubit.load();
        await _pump(
          tester,
          size: size,
          scale: scale,
          child: BlocProvider.value(
            value: cubit,
            child: const VendorDashboardPage(),
          ),
        );
      });

      testWidgets('agent today lays out at $label', (tester) async {
        final cubit = DashboardCubit(
          const MockDashboardGateway(),
          role: DashboardRole.agent,
        );
        await cubit.load();
        await _pump(
          tester,
          size: size,
          scale: scale,
          child: BlocProvider.value(
            value: cubit,
            child: const AgentTodayPage(),
          ),
        );
      });
    }
  }
}

Future<void> _pump(
  WidgetTester tester, {
  required Size size,
  required double scale,
  required Widget child,
}) async {
  await pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: child,
  );
  expect(tester.takeException(), isNull);
}
