import 'package:incacook/core/services/map/models/map_route.dart';

class PlaceSuggestion {
  const PlaceSuggestion({
    required this.placeId,
    required this.name,
    required this.placeFormatted,
    required this.featureType,
    this.fullAddress,
  });

  final String placeId;
  final String name;
  final String placeFormatted;
  final String? fullAddress;
  final String featureType;
}

//* Result of a place detail/reverse-geocode call. Has the full coordinate and
//* structured locality fields for the app's Address model.
class RetrievedPlace {
  const RetrievedPlace({
    required this.placeId,
    required this.name,
    required this.placeFormatted,
    required this.coordinate,
    this.fullAddress,
    this.city,
    this.postcode,
    this.country,
  });

  final String placeId;
  final String name;
  final String placeFormatted;
  final MapPoint coordinate;
  final String? fullAddress;

  //* Structured locality fields from the provider's address components.
  //* Null when the provider omits them.
  final String? city;
  final String? postcode;
  final String? country;
}
