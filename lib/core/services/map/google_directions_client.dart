import 'package:dio/dio.dart';
import 'package:incacook/core/config/google_maps_config.dart';
import 'package:incacook/core/services/map/models/map_route.dart';

class GoogleDirectionsClient {
  GoogleDirectionsClient({Dio? dio, String? apiKey})
      : _dio = dio ?? Dio(),
        _apiKey = apiKey ?? GoogleMapsConfig.apiKey,
        assert(
          (apiKey ?? GoogleMapsConfig.apiKey).isNotEmpty,
          GoogleMapsConfig.missingKeyMessage,
        );

  static const _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';

  final Dio _dio;
  final String _apiKey;

  Future<MapRoute> getRoute({
    required MapPoint origin,
    required MapPoint destination,
    String travelMode = 'driving',
  }) =>
      getRouteThrough([origin, destination], travelMode: travelMode);

  Future<MapRoute> getRouteThrough(
    List<MapPoint> waypoints, {
    String travelMode = 'driving',
  }) async {
    if (waypoints.length < 2) {
      throw ArgumentError('getRouteThrough requires at least 2 waypoints');
    }

    final origin = waypoints.first;
    final destination = waypoints.last;
    final middle = waypoints.length > 2
        ? waypoints.sublist(1, waypoints.length - 1)
        : const <MapPoint>[];

    final response = await _dio.get<Map<String, dynamic>>(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.lat},${origin.lng}',
        'destination': '${destination.lat},${destination.lng}',
        if (middle.isNotEmpty)
          'waypoints': middle.map((p) => '${p.lat},${p.lng}').join('|'),
        'mode': travelMode,
        'key': _apiKey,
      },
    );

    final data = response.data;
    if (data == null || data['status'] != 'OK') {
      throw const NoRouteFoundException();
    }

    final routes = (data['routes'] as List?)?.cast<Map<String, dynamic>>() ??
        const <Map<String, dynamic>>[];
    if (routes.isEmpty) throw const NoRouteFoundException();

    final route = routes.first;
    final polyline = route['overview_polyline'] as Map<String, dynamic>?;
    final encoded = polyline?['points'] as String?;
    if (encoded == null || encoded.isEmpty) throw const NoRouteFoundException();

    final legs =
        (route['legs'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
    double distanceMeters = 0;
    double durationSeconds = 0;
    for (final leg in legs) {
      distanceMeters +=
          ((leg['distance'] as Map<String, dynamic>?)?['value'] as num?)
                  ?.toDouble() ??
              0;
      durationSeconds +=
          ((leg['duration'] as Map<String, dynamic>?)?['value'] as num?)
                  ?.toDouble() ??
              0;
    }

    return MapRoute(
      points: _decodePolyline(encoded),
      distanceMeters: distanceMeters,
      durationSeconds: durationSeconds,
    );
  }

  static List<MapPoint> _decodePolyline(String encoded) {
    final points = <MapPoint>[];
    var index = 0;
    var lat = 0;
    var lng = 0;

    while (index < encoded.length) {
      final latResult = _decodeValue(encoded, index);
      index = latResult.nextIndex;
      lat += latResult.delta;

      final lngResult = _decodeValue(encoded, index);
      index = lngResult.nextIndex;
      lng += lngResult.delta;

      points.add(MapPoint(lat: lat / 1e5, lng: lng / 1e5));
    }

    return points;
  }

  static _PolylineValue _decodeValue(String encoded, int startIndex) {
    var index = startIndex;
    var result = 0;
    var shift = 0;
    int byte;
    do {
      byte = encoded.codeUnitAt(index++) - 63;
      result |= (byte & 0x1f) << shift;
      shift += 5;
    } while (byte >= 0x20);
    final delta = (result & 1) != 0 ? ~(result >> 1) : result >> 1;
    return _PolylineValue(delta: delta, nextIndex: index);
  }
}

class _PolylineValue {
  const _PolylineValue({required this.delta, required this.nextIndex});

  final int delta;
  final int nextIndex;
}

class NoRouteFoundException implements Exception {
  const NoRouteFoundException();

  @override
  String toString() => 'NoRouteFoundException: Google returned no routes.';
}
