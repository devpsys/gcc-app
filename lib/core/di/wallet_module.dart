import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_cubit.dart';
import 'package:gcc_app/features/agent_wallet/presentation/gateway/mock_wallet_gateway.dart';
import 'package:gcc_app/features/agent_wallet/presentation/gateway/wallet_gateway.dart';

/// Registers the bounty wallet's presentation dependencies.
void registerWalletModule() {
  getIt
    ..registerLazySingleton<WalletGateway>(MockWalletGateway.new)
    ..registerFactory<WalletCubit>(() => WalletCubit(getIt()));
}
