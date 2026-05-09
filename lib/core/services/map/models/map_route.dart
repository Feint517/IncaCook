import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_route.freezed.dart';
part 'map_route.g.dart';

@freezed
abstract class MapPoint with _$MapPoint {
  const factory MapPoint({
    required double lng,
    required double lat,
  }) = _MapPoint;

  factory MapPoint.fromJson(Map<String, dynamic> json) =>
      _$MapPointFromJson(json);
}

@freezed
abstract class MapRoute with _$MapRoute {
  const factory MapRoute({
    required List<MapPoint> points,
    required double distanceMeters,
    required double durationSeconds,
  }) = _MapRoute;

  factory MapRoute.fromJson(Map<String, dynamic> json) =>
      _$MapRouteFromJson(json);
}
