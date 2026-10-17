import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/agent_wallet/presentation/gateway/wallet_gateway.dart';
import 'package:gcc_app/features/agent_wallet/presentation/gateway/unwired_wallet_gateway.dart';

/// Registers the bounty wallet's presentation dependencies.
void registerWalletModule() {
  getIt.registerLazySingleton<WalletGateway>(UnwiredWalletGateway.new);
}
