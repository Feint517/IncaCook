import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:incacook/core/services/map/google_directions_client.dart';
import 'package:incacook/core/services/map/models/map_route.dart';
import 'package:incacook/core/utils/log.dart';
import 'package:incacook/features/orders/controllers/order_tracking_controller.dart';

/// Buyer-side live tracking map. Renders the trip points as native Google Maps
/// markers and a routed polyline for the active leg. No coordinate is ever
/// faked — an unset (0,0) point is simply not drawn.
class OnTheWayStageView extends StatefulWidget {
  const OnTheWayStageView({super.key});

  @override
  State<OnTheWayStageView> createState() => _OnTheWayStageViewState();
}

class _OnTheWayStageViewState extends State<OnTheWayStageView> {
  static const Color _routeColor = Color(0xFF0066FF);

  final OrderTrackingController _controller = OrderTrackingController.instance;

  GoogleMapController? _map;
  Set<Marker> _markers = const {};
  Set<Polyline> _polylines = const {};

  Worker? _positionWorker;
  Worker? _phaseWorker;
  Worker? _snapshotWorker;

  MapRoute? _routeForCurrentLeg;
  TrackingPhase? _routedPhase;
  bool _fetchingRoute = false;
  bool _framedWithDriver = false;

  MapPoint get _driver => _controller.driverPosition.value;
  MapPoint get _seller => _controller.pickupPoint;
  MapPoint get _client => _controller.dropoffPoint;

  bool _isReal(MapPoint p) => p.lng != 0 || p.lat != 0;
  bool get _hasDriverFix => _controller.hasAssignedDriver && _isReal(_driver);

  LatLng _latLng(MapPoint p) => LatLng(p.lat, p.lng);

  List<MapPoint> get _routeStops {
    final ordered = _controller.phase.value == TrackingPhase.awaitingPickup
        ? <MapPoint>[_driver, _seller, _client]
        : <MapPoint>[_driver, _client];
    return ordered.where(_isReal).toList();
  }

  List<MapPoint> get _cameraPoints => <MapPoint>[
        if (_isReal(_seller)) _seller,
        if (_isReal(_client)) _client,
        if (_hasDriverFix) _driver,
      ];

  MapPoint get _initialCenter {
    final pts = _cameraPoints;
    if (pts.isEmpty) return const MapPoint(lng: 2.3522, lat: 48.8566);
    final lng = pts.map((p) => p.lng).reduce((a, b) => a + b) / pts.length;
    final lat = pts.map((p) => p.lat).reduce((a, b) => a + b) / pts.length;
    return MapPoint(lng: lng, lat: lat);
  }

  @override
  void initState() {
    super.initState();
    _positionWorker = ever<MapPoint>(_controller.driverPosition, (_) async {
      await _updateDriverMarker();
      await _refreshPolyline();
    });
    _phaseWorker = ever<TrackingPhase>(_controller.phase, (_) async {
      await _redrawAllMarkers();
      await _refreshPolyline();
      await _fitCamera();
    });
    _snapshotWorker = ever<bool>(_controller.snapshotReady, (ready) async {
      if (!ready) return;
      await _redrawAllMarkers();
      await _refreshPolyline();
      await _fitCamera();
    });
  }

  @override
  void dispose() {
    _positionWorker?.dispose();
    _phaseWorker?.dispose();
    _snapshotWorker?.dispose();
    super.dispose();
  }

  Future<void> _onMapCreated(GoogleMapController map) async {
    _map = map;
    await _redrawAllMarkers();
    await _refreshPolyline();
    await _fitCamera();
    logInfo(
      '[TrackingMap] view drawn — seller=${_isReal(_seller)} '
      'client=${_isReal(_client)} driver=$_hasDriverFix '
      'markers=${_cameraPoints.length}',
    );
  }

  Future<void> _redrawAllMarkers() async {
    if (!mounted) return;
    final markers = <Marker>{};
    if (_isReal(_seller)) {
      markers.add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: _latLng(_seller),
          infoWindow: const InfoWindow(title: 'Retrait'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
        ),
      );
    }
    if (_isReal(_client)) {
      markers.add(
        Marker(
          markerId: const MarkerId('dropoff'),
          position: _latLng(_client),
          infoWindow: const InfoWindow(title: 'Livraison'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        ),
      );
    }
    if (_hasDriverFix) markers.add(_driverMarker());
    setState(() => _markers = markers);
  }

  Future<void> _updateDriverMarker() async {
    if (!mounted || !_hasDriverFix) return;
    setState(() {
      _markers = {
        for (final marker in _markers)
          if (marker.markerId.value != 'driver') marker,
        _driverMarker(),
      };
    });
    if (!_framedWithDriver) {
      _framedWithDriver = true;
      await _fitCamera();
    }
  }

  Marker _driverMarker() {
    return Marker(
      markerId: const MarkerId('driver'),
      position: _latLng(_driver),
      infoWindow: const InfoWindow(title: 'Livreur'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );
  }

  Future<void> _refreshPolyline() async {
    if (!mounted) return;
    final phase = _controller.phase.value;
    final stops = _routeStops;

    final needsRouteFetch = _routedPhase != phase && !_fetchingRoute;
    if (needsRouteFetch && stops.length >= 2) {
      _fetchingRoute = true;
      try {
        final client = Get.isRegistered<GoogleDirectionsClient>()
            ? Get.find<GoogleDirectionsClient>()
            : GoogleDirectionsClient();
        _routeForCurrentLeg = await client.getRouteThrough(stops);
        _routedPhase = phase;
      } catch (_) {
        _routeForCurrentLeg = null;
      } finally {
        _fetchingRoute = false;
      }
      if (!mounted) return;
    }

    final points = _routeForCurrentLeg?.points ?? stops;
    if (points.length < 2) return;

    setState(() {
      _polylines = {
        Polyline(
          polylineId: const PolylineId('active-leg'),
          points: points.map(_latLng).toList(),
          color: _routeColor,
          width: 6,
        ),
      };
    });
  }

  Future<void> _fitCamera() async {
    final map = _map;
    if (map == null || !mounted) return;
    final pts = _cameraPoints;
    if (pts.isEmpty) return;
    if (pts.length == 1) {
      await map.animateCamera(
        CameraUpdate.newLatLngZoom(_latLng(pts.first), 14),
      );
      return;
    }

    var minLat = pts.first.lat;
    var maxLat = pts.first.lat;
    var minLng = pts.first.lng;
    var maxLng = pts.first.lng;
    for (final p in pts) {
      if (p.lat < minLat) minLat = p.lat;
      if (p.lat > maxLat) maxLat = p.lat;
      if (p.lng < minLng) minLng = p.lng;
      if (p.lng > maxLng) maxLng = p.lng;
    }

    try {
      await map.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(minLat, minLng),
            northeast: LatLng(maxLat, maxLng),
          ),
          80,
        ),
      );
    } catch (_) {
      // Keep the current camera on any framing error.
    }
  }

  @override
  Widget build(BuildContext context) {
    final center = _initialCenter;
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(center.lat, center.lng),
        zoom: 13,
      ),
      markers: _markers,
      polylines: _polylines,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      onMapCreated: _onMapCreated,
    );
  }
}
