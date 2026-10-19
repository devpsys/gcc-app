import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_listing_state.dart';
import 'package:gcc_app/features/marketplace/presentation/gateway/marketplace_gateway.dart';

class MarketplaceListingCubit extends Cubit<MarketplaceListingState> {
  MarketplaceListingCubit(this._gateway, this.id)
    : super(const MarketplaceListingLoading());

  final MarketplaceGateway _gateway;
  final String id;

  Future<void> load() async {
    emit(const MarketplaceListingLoading());
    try {
      final catalog = await _gateway.load();
      MarketplaceListingReady? ready;
      for (final listing in catalog.listings) {
        if (listing.id != id) {
          continue;
        }
        ready = MarketplaceListingReady(
          listing: listing,
          similar: [
            for (final other in catalog.listings)
              if (other.id != listing.id && other.category == listing.category)
                other,
          ],
        );
        break;
      }
      emit(ready ?? const MarketplaceListingMissing());
    } on Failure catch (failure) {
      emit(MarketplaceListingFailed(failure));
    }
  }
}
