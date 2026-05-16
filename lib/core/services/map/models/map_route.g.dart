// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MapPoint _$MapPointFromJson(Map<String, dynamic> json) => _MapPoint(
  lng: (json['lng'] as num).toDouble(),
  lat: (json['lat'] as num).toDouble(),
);

Map<String, dynamic> _$MapPointToJson(_MapPoint instance) => <String, dynamic>{
  'lng': instance.lng,
  'lat': instance.lat,
};

_MapRoute _$MapRouteFromJson(Map<String, dynamic> json) => _MapRoute(
  points: (json['points'] as List<dynamic>)
      .map((e) => MapPoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  distanceMeters: (json['distanceMeters'] as num).toDouble(),
  durationSeconds: (json['durationSeconds'] as num).toDouble(),
);

Map<String, dynamic> _$MapRouteToJson(_MapRoute instance) => <String, dynamic>{
  'points': instance.points.map((e) => e.toJson()).toList(),
  'distanceMeters': instance.distanceMeters,
  'durationSeconds': instance.durationSeconds,
};
