import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';
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
      MarketplaceListing? listing;
      for (final item in catalog.listings) {
        if (item.id == id) {
          listing = item;
          break;
        }
      }
      if (listing == null) {
        emit(const MarketplaceListingMissing());
        return;
      }
      final byId = {for (final item in catalog.listings) item.id: item};
      final similar = <MarketplaceListing>[
        for (final similarId in listing.similarIds) ?byId[similarId],
      ];
      emit(MarketplaceListingReady(listing: listing, similar: similar));
    } on Failure catch (failure) {
      emit(MarketplaceListingFailed(failure));
    }
  }
}
