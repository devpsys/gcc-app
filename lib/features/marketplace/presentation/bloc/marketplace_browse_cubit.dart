import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_filters.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_state.dart';
import 'package:gcc_app/features/marketplace/presentation/gateway/marketplace_gateway.dart';

class MarketplaceBrowseCubit extends Cubit<MarketplaceBrowseState> {
  MarketplaceBrowseCubit(this._gateway)
    : super(const MarketplaceBrowseLoading());

  final MarketplaceGateway _gateway;

  Future<void> load() async {
    emit(const MarketplaceBrowseLoading());
    try {
      final catalog = await _gateway.load();
      emit(
        MarketplaceBrowseReady(
          listings: catalog.listings,
          recentSearches: catalog.recentSearches,
          bookingsWaiting: catalog.bookingsWaiting,
        ),
      );
    } on Failure catch (failure) {
      emit(MarketplaceBrowseFailed(failure));
    }
  }

  void setMode(MarketplaceMode mode) {
    final ready = _ready;
    if (ready == null || ready.mode == mode) {
      return;
    }
    emit(ready.copyWith(mode: mode));
  }

  void setQuery(String query) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(ready.copyWith(filters: ready.filters.copyWith(query: query)));
  }

  void clearRecent() {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(ready.copyWith(recentSearches: const []));
  }

  void setMarket(String? market) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(
      ready.copyWith(
        filters: ready.filters.copyWith(
          market: market,
          clearMarket: market == null,
        ),
      ),
    );
  }

  void toggleCategory(String category) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    final next = {...ready.filters.categories};
    if (!next.add(category)) {
      next.remove(category);
    }
    emit(ready.copyWith(filters: ready.filters.copyWith(categories: next)));
  }

  void toggleAvailableNow() {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(
      ready.copyWith(
        filters: ready.filters.copyWith(
          availableNow: !ready.filters.availableNow,
        ),
      ),
    );
  }

  void toggleOperator() {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(
      ready.copyWith(
        filters: ready.filters.copyWith(
          withOperator: !ready.filters.withOperator,
        ),
      ),
    );
  }

  void toggleDepositUnder() {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    if (!ready.filters.depositUnder && ready.filters.maxRate != null) {
      emit(ready.copyWith(rateDepositConflict: true));
      return;
    }
    emit(
      ready.copyWith(
        rateDepositConflict: false,
        filters: ready.filters.copyWith(
          depositUnder: !ready.filters.depositUnder,
        ),
      ),
    );
  }

  void setMaxRate(int? rate) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    if (rate != null && ready.filters.depositUnder) {
      emit(ready.copyWith(rateDepositConflict: true));
      return;
    }
    emit(
      ready.copyWith(
        rateDepositConflict: false,
        filters: ready.filters.copyWith(
          maxRate: rate,
          clearMaxRate: rate == null,
        ),
      ),
    );
  }

  void clearFilters() {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(
      ready.copyWith(
        rateDepositConflict: false,
        filters: MarketplaceFilters(query: ready.filters.query),
      ),
    );
  }

  MarketplaceBrowseReady? get _ready => switch (state) {
    MarketplaceBrowseReady ready => ready,
    _ => null,
  };
}
