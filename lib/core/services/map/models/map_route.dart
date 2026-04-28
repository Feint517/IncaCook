class MapPoint {
  const MapPoint({required this.lng, required this.lat});

  final double lng;
  final double lat;
}

class MapRoute {
  const MapRoute({
    required this.points,
    required this.distanceMeters,
    required this.durationSeconds,
  });

  final List<MapPoint> points;
  final double distanceMeters;
  final double durationSeconds;
}
