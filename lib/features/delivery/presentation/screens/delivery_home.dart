import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:get/get.dart';
import 'package:homemade/core/constants/sizes.dart';
import 'package:homemade/features/orders/presentation/screens/order_tracking.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'package:homemade/core/services/location/location_service.dart';
import 'package:homemade/core/services/map/mapbox_directions_client.dart';
import 'package:homemade/core/services/map/models/map_route.dart';
import 'package:homemade/core/utils/theme/theme_extensions.dart';
import 'package:homemade/core/widgets/effects/frosted_surface.dart';
import 'package:homemade/features/orders/data/order_mock_data.dart';
import 'package:homemade/features/orders/domain/order_detail.dart';

class DeliveryHomeScreen extends StatefulWidget {
  const DeliveryHomeScreen({super.key});

  @override
  State<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  //* Mock active order. Replace with real assignment when orders flow
  //* through the backend. Delivery orders are expected to have a geocoded
  //* address — this screen would not be reachable for pickup-only orders.
  final OrderDetail _order = OrderMockData.demoOrder();

  MapPoint get _pickup => _order.seller.location;
  MapPoint get _dropoff => _order.deliveryDetails!.address.coordinate!;

  MapboxMap? _map;
  PolylineAnnotationManager? _polylineManager;
  CircleAnnotationManager? _circleManager;

  MapRoute? _route;
  String? _error;
  bool _loading = true;

  //* Off-route detection state.
  static const double _offRouteThresholdMeters = 50;
  static const int _offRouteHitsBeforeReroute = 3;
  Worker? _positionWorker;
  int _offRouteHits = 0;
  bool _refetching = false;

  @override
  void dispose() {
    _positionWorker?.dispose();
    LocationService.instance.stop();
    super.dispose();
  }

  Future<void> _onMapCreated(MapboxMap map) async {
    _map = map;
    await map.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    await map.location.updateSettings(
      LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );
    await map.logo.updateSettings(
      LogoSettings(
        enabled: true,
        position: OrnamentPosition.TOP_RIGHT,
        marginRight: AppSizes.md,
      ),
    );
    await map.attribution.updateSettings(
      AttributionSettings(
        enabled: false,
        position: OrnamentPosition.BOTTOM_RIGHT,
        iconColor: 0xFF000000,
        marginBottom: AppSizes.md,
        clickable: false,
      ),
    );
    await map.compass.updateSettings(
      CompassSettings(
        enabled: false,
        position: OrnamentPosition.TOP_LEFT,
        marginTop: 80,
        marginLeft: 16,
      ),
    );

    _polylineManager = await map.annotations.createPolylineAnnotationManager();
    _circleManager = await map.annotations.createCircleAnnotationManager();
    await _bootstrap();
  }

  Future<void> _bootstrap() async {
    final pos = await LocationService.instance.getCurrent();
    if (pos == null) {
      _setState(loading: false, error: "Localisation indisponible");
      return;
    }

    final origin = MapPoint(lng: pos.longitude, lat: pos.latitude);
    try {
      final route = await Get.find<MapboxDirectionsClient>().getRoute(
        origin: origin,
        destination: _dropoff,
      );
      await _drawRoute(route);
      await _drawMarkers();
      await _frameRoute(route);
      _setState(loading: false, route: route);
      await LocationService.instance.start();
      _startPositionWatcher();
    } catch (_) {
      _setState(loading: false, error: "Itinéraire introuvable");
    }
  }

  void _startPositionWatcher() {
    _positionWorker?.dispose();
    _positionWorker = ever<geo.Position?>(
      LocationService.instance.currentPosition,
      _onPositionUpdate,
    );
  }

  Future<void> _onPositionUpdate(geo.Position? pos) async {
    final route = _route;
    if (pos == null || route == null || _refetching) return;

    final current = MapPoint(lng: pos.longitude, lat: pos.latitude);
    final distance = _distanceToPolyline(current, route.points);
    if (distance > _offRouteThresholdMeters) {
      _offRouteHits++;
      if (_offRouteHits >= _offRouteHitsBeforeReroute) {
        _offRouteHits = 0;
        await _refetchRoute(current);
      }
    } else {
      _offRouteHits = 0;
    }
  }

  Future<void> _refetchRoute(MapPoint origin) async {
    _refetching = true;
    try {
      final route = await Get.find<MapboxDirectionsClient>().getRoute(
        origin: origin,
        destination: _dropoff,
      );
      await _polylineManager?.deleteAll();
      await _drawRoute(route);
      _setState(route: route);
    } catch (_) {
      //? swallow — try again on the next off-route trip
    } finally {
      _refetching = false;
    }
  }

  //* Great-circle distance (Haversine) between two points, in meters.
  double _greatCircleDistance(MapPoint a, MapPoint b) {
    const earthRadius = 6371000.0;
    final lat1 = a.lat * math.pi / 180;
    final lat2 = b.lat * math.pi / 180;
    final dLat = (b.lat - a.lat) * math.pi / 180;
    final dLng = (b.lng - a.lng) * math.pi / 180;
    final h = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) * math.cos(lat2) * math.sin(dLng / 2) * math.sin(dLng / 2);
    return 2 * earthRadius * math.asin(math.sqrt(h));
  }

  //* Distance from [p] to the segment [a]-[b], in meters. Uses lng/lat as a
  //* flat plane to project the point — good enough for the urban-scale
  //* segments produced by the Directions API.
  double _pointToSegmentDistance(MapPoint p, MapPoint a, MapPoint b) {
    final dx = b.lng - a.lng;
    final dy = b.lat - a.lat;
    final lenSq = dx * dx + dy * dy;
    if (lenSq == 0) return _greatCircleDistance(p, a);
    var t = ((p.lng - a.lng) * dx + (p.lat - a.lat) * dy) / lenSq;
    t = t.clamp(0.0, 1.0);
    final closest = MapPoint(lng: a.lng + t * dx, lat: a.lat + t * dy);
    return _greatCircleDistance(p, closest);
  }

  double _distanceToPolyline(MapPoint p, List<MapPoint> route) {
    if (route.isEmpty) return double.infinity;
    if (route.length == 1) return _greatCircleDistance(p, route.first);
    var minDist = double.infinity;
    for (var i = 0; i < route.length - 1; i++) {
      final d = _pointToSegmentDistance(p, route[i], route[i + 1]);
      if (d < minDist) minDist = d;
    }
    return minDist;
  }

  void _setState({bool? loading, MapRoute? route, String? error}) {
    if (!mounted) return;
    setState(() {
      if (loading != null) _loading = loading;
      if (route != null) _route = route;
      if (error != null) _error = error;
    });
  }

  Future<void> _drawRoute(MapRoute route) async {
    final coords = route.points.map((p) => Position(p.lng, p.lat)).toList();
    await _polylineManager!.create(
      PolylineAnnotationOptions(
        geometry: LineString(coordinates: coords),
        lineWidth: 6.0,
        lineColor: 0xFF0066FF,
      ),
    );
  }

  Future<void> _drawMarkers() async {
    //* Pickup — seller's location (orange).
    await _circleManager!.create(
      CircleAnnotationOptions(
        geometry: Point(coordinates: Position(_pickup.lng, _pickup.lat)),
        circleRadius: 10.0,
        circleColor: 0xFFE8823B,
        circleStrokeWidth: 3.0,
        circleStrokeColor: 0xFFFFFFFF,
      ),
    );
    //* Dropoff — customer's address (red).
    await _circleManager!.create(
      CircleAnnotationOptions(
        geometry: Point(coordinates: Position(_dropoff.lng, _dropoff.lat)),
        circleRadius: 10.0,
        circleColor: 0xFFFF3B30,
        circleStrokeWidth: 3.0,
        circleStrokeColor: 0xFFFFFFFF,
      ),
    );
  }

  Future<void> _frameRoute(MapRoute route) async {
    if (route.points.isEmpty || _map == null) return;
    var minLng = route.points.first.lng, maxLng = minLng;
    var minLat = route.points.first.lat, maxLat = minLat;
    for (final p in route.points) {
      minLng = math.min(minLng, p.lng);
      maxLng = math.max(maxLng, p.lng);
      minLat = math.min(minLat, p.lat);
      maxLat = math.max(maxLat, p.lat);
    }
    await _map!.flyTo(
      CameraOptions(
        center: Point(
          coordinates: Position((minLng + maxLng) / 2, (minLat + maxLat) / 2),
        ),
        zoom: 12.5,
      ),
      MapAnimationOptions(duration: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    final styleUri = context.isDark ? MapboxStyles.DARK : MapboxStyles.LIGHT;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          MapWidget(
            styleUri: styleUri,
            cameraOptions: CameraOptions(
              center: Point(coordinates: Position(2.3522, 48.8566)),
              zoom: 11.0,
            ),
            onMapCreated: _onMapCreated,
          ),
          Positioned(
            top: MediaQuery.viewPaddingOf(context).top + 16,
            left: 16,
            right: 16,
            child: _TopOverlay(loading: _loading, error: _error, route: _route),
          ),
        ],
      ),
    );
  }
}

class _TopOverlay extends StatelessWidget {
  const _TopOverlay({
    required this.loading,
    required this.error,
    required this.route,
  });

  final bool loading;
  final String? error;
  final MapRoute? route;

  @override
  Widget build(BuildContext context) {
    if (route != null) return _RouteSummaryCard(route: route!);
    if (error != null) return _Chip(label: error!);
    if (loading) return const _Chip(label: "Calcul de l'itinéraire…");
    return const SizedBox.shrink();
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FrostedSurface(
        borderRadius: BorderRadius.circular(24),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}

class _RouteSummaryCard extends StatelessWidget {
  const _RouteSummaryCard({required this.route});

  final MapRoute route;

  @override
  Widget build(BuildContext context) {
    final mins = (route.durationSeconds / 60).round();
    final km = (route.distanceMeters / 1000).toStringAsFixed(1);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return FrostedSurface(
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.clock, size: 20, color: scheme.onSurface),
          const Gap(8),
          Text('$mins min', style: textTheme.titleSmall),
          const Gap(20),
          Icon(Iconsax.routing, size: 20, color: scheme.onSurface),
          const Gap(8),
          Text('$km km', style: textTheme.titleSmall),
          IconButton(
            onPressed: () => Get.to(() => const OrderTrackingScreen()),
            icon: const Icon(Iconsax.info_circle, size: 20),
          ),
        ],
      ),
    );
  }
}
