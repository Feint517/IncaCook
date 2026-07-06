import 'package:incacook/core/models/food_listing.dart';
import 'package:incacook/core/models/listing.dart';
import 'package:incacook/core/services/map/models/map_route.dart';

/// Bundle of a [FoodListing] with the geographic [MapPoint] where it should
/// be pinned on the map. Lives in the map feature because the pairing only
/// matters for the map view.
class MapEntry {
  const MapEntry({required this.position, required this.listing, this.source});

  final MapPoint position;
  final FoodListing listing;

  /// The real backend record this pin was built from, so a tap can open the
  /// correct listing detail. Null only for legacy/mock entries.
  final Listing? source;
}
