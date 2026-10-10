import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/auth/presentation/agent_auth_gateway.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_auth_cubit.dart';
import 'package:gcc_app/features/auth/presentation/unwired_agent_auth_gateway.dart';

void registerAuthModule() {
  getIt
    ..registerLazySingleton<AgentAuthGateway>(UnwiredAgentAuthGateway.new)
    ..registerFactory(() => AgentAuthCubit(getIt()));
}
