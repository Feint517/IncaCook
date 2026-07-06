import 'package:dio/dio.dart';
import 'package:incacook/core/config/google_maps_config.dart';
import 'package:incacook/core/services/map/models/map_route.dart';
import 'package:incacook/core/services/map/models/place_suggestion.dart';

class GooglePlacesClient {
  GooglePlacesClient({Dio? dio, String? apiKey})
      : _dio = dio ?? Dio(),
        _apiKey = apiKey ?? GoogleMapsConfig.apiKey,
        assert(
          (apiKey ?? GoogleMapsConfig.apiKey).isNotEmpty,
          GoogleMapsConfig.missingKeyMessage,
        );

  static const _placesBaseUrl = 'https://maps.googleapis.com/maps/api/place';
  static const _geocodeBaseUrl =
      'https://maps.googleapis.com/maps/api/geocode/json';

  final Dio _dio;
  final String _apiKey;

  String newSessionToken() => DateTime.now().microsecondsSinceEpoch.toString();

  Future<List<PlaceSuggestion>> suggest({
    required String query,
    required String sessionToken,
    String? language,
    String? country,
    MapPoint? proximity,
    int limit = 8,
  }) async {
    if (query.trim().isEmpty) return [];

    final queryParameters = <String, dynamic>{
      'input': query,
      'sessiontoken': sessionToken,
      'key': _apiKey,
    };
    if (language != null) queryParameters['language'] = language;
    if (country != null) queryParameters['components'] = 'country:$country';
    if (proximity != null) {
      queryParameters['location'] = '${proximity.lat},${proximity.lng}';
      queryParameters['radius'] = 50000;
    }

    final response = await _dio.get<Map<String, dynamic>>(
      '$_placesBaseUrl/autocomplete/json',
      queryParameters: queryParameters,
    );

    final data = response.data;
    if (data == null || data['status'] == 'ZERO_RESULTS') return [];
    if (data['status'] != 'OK') throw const PlaceNotFoundException();

    final predictions =
        (data['predictions'] as List?)?.cast<Map<String, dynamic>>() ??
            const <Map<String, dynamic>>[];
    return predictions.take(limit).map((prediction) {
      final formatting =
          prediction['structured_formatting'] as Map<String, dynamic>?;
      final types = (prediction['types'] as List?)?.cast<String>() ?? const [];
      return PlaceSuggestion(
        placeId: prediction['place_id'] as String,
        name: formatting?['main_text'] as String? ??
            prediction['description'] as String? ??
            '',
        placeFormatted: formatting?['secondary_text'] as String? ?? '',
        fullAddress: prediction['description'] as String?,
        featureType: types.isEmpty ? '' : types.first,
      );
    }).toList();
  }

  Future<RetrievedPlace> retrieve({
    required String placeId,
    required String sessionToken,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '$_placesBaseUrl/details/json',
      queryParameters: {
        'place_id': placeId,
        'sessiontoken': sessionToken,
        'fields': 'place_id,name,formatted_address,address_components,geometry',
        'key': _apiKey,
      },
    );

    final data = response.data;
    if (data == null || data['status'] != 'OK') {
      throw const PlaceNotFoundException();
    }
    final result = data['result'] as Map<String, dynamic>?;
    if (result == null) throw const PlaceNotFoundException();
    return _placeFromGoogleResult(result, fallbackPlaceId: placeId);
  }

  Future<RetrievedPlace> reverse({
    required double lat,
    required double lng,
    String? language,
  }) async {
    final queryParameters = <String, dynamic>{
      'latlng': '$lat,$lng',
      'key': _apiKey,
    };
    if (language != null) queryParameters['language'] = language;

    final response = await _dio.get<Map<String, dynamic>>(
      _geocodeBaseUrl,
      queryParameters: queryParameters,
    );

    final data = response.data;
    if (data == null || data['status'] == 'ZERO_RESULTS') {
      throw const PlaceNotFoundException();
    }
    if (data['status'] != 'OK') throw const PlaceNotFoundException();

    final results = (data['results'] as List?)?.cast<Map<String, dynamic>>() ??
        const <Map<String, dynamic>>[];
    if (results.isEmpty) throw const PlaceNotFoundException();
    return _placeFromGoogleResult(results.first);
  }

  static RetrievedPlace _placeFromGoogleResult(
    Map<String, dynamic> result, {
    String? fallbackPlaceId,
  }) {
    final geometry = result['geometry'] as Map<String, dynamic>?;
    final location = geometry?['location'] as Map<String, dynamic>?;
    final lat = (location?['lat'] as num?)?.toDouble();
    final lng = (location?['lng'] as num?)?.toDouble();
    if (lat == null || lng == null) throw const PlaceNotFoundException();

    final components =
        (result['address_components'] as List?)?.cast<Map<String, dynamic>>() ??
            const <Map<String, dynamic>>[];

    String? pick(String type) {
      for (final component in components) {
        final types = (component['types'] as List?)?.cast<String>() ?? const [];
        if (types.contains(type)) return component['long_name'] as String?;
      }
      return null;
    }

    final fullAddress = result['formatted_address'] as String? ?? '';
    return RetrievedPlace(
      placeId: result['place_id'] as String? ?? fallbackPlaceId ?? '',
      name: result['name'] as String? ?? fullAddress,
      placeFormatted: fullAddress,
      fullAddress: fullAddress,
      city: pick('locality') ??
          pick('postal_town') ??
          pick('administrative_area_level_2'),
      postcode: pick('postal_code'),
      country: pick('country'),
      coordinate: MapPoint(lng: lng, lat: lat),
    );
  }
}

class PlaceNotFoundException implements Exception {
  const PlaceNotFoundException();

  @override
  String toString() =>
      'PlaceNotFoundException: Google returned no place for the given place_id.';
}
