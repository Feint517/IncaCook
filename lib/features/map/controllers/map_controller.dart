import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:incacook/core/enums/food_enums.dart';
import 'package:incacook/core/models/listing_mappers.dart';
import 'package:incacook/core/services/location/location_service.dart';
import 'package:incacook/core/services/map/models/map_route.dart';
import 'package:incacook/features/catalog/data/models/requests/list_listings_query.dart';
import 'package:incacook/features/catalog/data/repositories/listings_repository.dart';
import 'package:incacook/features/map/domain/map_entry.dart';
import 'package:incacook/features/map/presentation/widget/map_filter_bar.dart';

/// Owns map state for [MapScreen]: the real backend listings (pinned by
/// seller location), the selected filter, the tapped pin, and the projected
/// selected pin.
/// The screen reads these reactively via [Obx] and stays UI-only.
class MapController extends GetxController {
  static MapController get instance => Get.isRegistered<MapController>()
      ? Get.find<MapController>()
      : Get.put(MapController());

  /// Map centre / user dot. Defaults to central Paris until the device
  /// location resolves; updated to the real position in [loadListings].
  final Rx<MapPoint> userLocation =
      const MapPoint(lng: 2.3522, lat: 48.8566).obs;
  static const double initialZoom = 14;
  static const Duration urgentWindow = Duration(hours: 2, minutes: 30);

  /// Real listings from `GET /v1/listings`, one pin each (only listings whose
  /// seller has geocoded coordinates). Filter applied via [visibleEntries].
  final RxList<MapEntry> entries = <MapEntry>[].obs;
  final RxBool loading = true.obs;

  // ── Reactive UI state ─────────────────────────────────────────────────

  final Rx<MapFilter> selectedFilter = MapFilter.all.obs;
  final RxnString selectedId = RxnString();

  // ── Map handle + projection generation ────────────────────────────────

  GoogleMapController? _map;

  @override
  void onInit() {
    super.onInit();
    unawaited(loadListings());
  }

  /// Resolves the device location (best-effort), fetches the real feed, and
  /// builds a pin per listing that has seller coordinates. Never throws —
  /// on any failure the map simply shows no pins.
  Future<void> loadListings() async {
    loading.value = true;
    double? lat;
    double? lng;
    try {
      final loc = Get.isRegistered<LocationService>()
          ? LocationService.instance
          : Get.put(LocationService(), permanent: true);
      final pos = await loc.getCurrent();
      if (pos != null) {
        lat = pos.latitude;
        lng = pos.longitude;
        userLocation.value = MapPoint(lng: lng, lat: lat);
      }
    } catch (_) {
      // keep the fallback centre — never crash on location.
    }

    try {
      final query = (lat != null && lng != null)
          ? ListListingsQuery(
              lat: lat,
              lng: lng,
              sort: ListingFeedSort.distance,
              limit: 100,
            )
          : const ListListingsQuery(limit: 100);
      final result = await ListingsRepository().getFeed(query);
      entries.assignAll([
        for (final l in result.items)
          if (l.lat != null && l.lng != null)
            MapEntry(
              position: MapPoint(lng: l.lng!, lat: l.lat!),
              listing: l.toFoodListing(),
              source: l,
            ),
      ]);
    } catch (_) {
      entries.clear();
    } finally {
      loading.value = false;
      if (lat != null && lng != null) unawaited(centerOnUser());
    }
  }

  // ── Derived data ──────────────────────────────────────────────────────

  bool isUrgent(MapEntry e) =>
      e.listing.expiresAt.difference(DateTime.now()) <= urgentWindow;

  bool _matchesFilter(MapEntry e, MapFilter filter) {
    switch (filter) {
      case MapFilter.all:
        return true;
      case MapFilter.social:
        return e.listing.category == SellerCategory.faitMaison;
      case MapFilter.traiteur:
        return e.listing.category == SellerCategory.traiteur;
      case MapFilter.restaurant:
        return e.listing.category == SellerCategory.restaurant;
      case MapFilter.urgent:
        return isUrgent(e);
    }
  }

  List<MapEntry> get visibleEntries =>
      entries.where((e) => _matchesFilter(e, selectedFilter.value)).toList();

  // ── Map lifecycle / camera ────────────────────────────────────────────

  Future<void> onMapCreated(GoogleMapController map) async {
    _map = map;
  }

  Future<void> centerOnUser() async {
    final loc = userLocation.value;
    await _map?.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(loc.lat, loc.lng), initialZoom),
    );
  }

  Future<void> flyToCurrentZoom(MapPoint pos) async {
    final map = _map;
    if (map == null) return;
    await map.animateCamera(
      CameraUpdate.newLatLng(LatLng(pos.lat, pos.lng)),
    );
  }

  // ── User actions ──────────────────────────────────────────────────────

  void setFilter(MapFilter f) {
    selectedFilter.value = f;
  }

  void setSelected(String? id) => selectedId.value = id;
}
