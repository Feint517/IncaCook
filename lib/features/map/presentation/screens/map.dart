import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:homemade/core/common/widgets/appbar/appbar.dart';
import 'package:homemade/core/constants/image_strings.dart';
import 'package:homemade/core/constants/sizes.dart';
import 'package:homemade/core/enums/food_enums.dart';
import 'package:homemade/core/enums/order_enums.dart';
import 'package:homemade/core/utils/popups/blurred_modal_sheet.dart';
import 'package:homemade/core/utils/theme/theme_extensions.dart';
import 'package:homemade/features/catalog/presentation/screens/product_detail.dart';
import 'package:homemade/features/client/domain/food_listing.dart';
import 'package:homemade/features/map/presentation/widget/center_on_user_button.dart';
import 'package:homemade/features/map/presentation/widget/map_filter_bar.dart';
import 'package:homemade/features/map/presentation/widget/map_listing_sheet.dart';
import 'package:homemade/features/map/presentation/widget/map_pin.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //? static demo user location — swap for geolocator lookup later
  static final Position _userLocation = Position(2.3522, 48.8566);
  static const double _initialZoom = 14;
  static const Duration _urgentWindow = Duration(hours: 2, minutes: 30);

  static const double _pinWidth = 84;
  static const double _pinHeight = 72;
  static const double _userDotSize = 44;

  MapboxMap? _map;

  //* Bumped on every projection request; results from stale generations are
  //* dropped to avoid jitter when many camera events fire in quick succession.
  int _projectionGen = 0;

  //* Latest projected screen positions, indexed against [_visibleEntries].
  List<ScreenCoordinate?> _pinScreenCoords = const [];
  ScreenCoordinate? _userScreenCoord;

  MapFilter _selectedFilter = MapFilter.all;
  String? _selectedId;

  late final List<_MapEntry> _entries = _buildEntries();

  List<_MapEntry> _buildEntries() {
    final now = DateTime.now();
    return [
      _MapEntry(
        position: Position(2.3530, 48.8580),
        listing: FoodListing(
          id: 'm1',
          name: 'Tajine poulet olives',
          imagePath: AppImages.foodTest,
          sellerName: 'Fatima',
          category: SellerCategory.faitMaison,
          distanceKm: 0.3,
          rating: 4.9,
          reviewCount: 24,
          dietaryTags: const [DietaryTag.halal],
          portionsLeft: 4,
          fulfillment: Fulfillment.delivery,
          originalPrice: 8.00,
          price: 3.00,
          expiresAt: now.add(const Duration(hours: 2)),
        ),
      ),
      _MapEntry(
        position: Position(2.3490, 48.8610),
        listing: FoodListing(
          id: 'm2',
          name: 'Lasagne maison',
          imagePath: AppImages.foodTest,
          sellerName: 'Chez Luigi',
          category: SellerCategory.traiteur,
          distanceKm: 0.8,
          rating: 4.7,
          reviewCount: 56,
          portionsLeft: 6,
          fulfillment: Fulfillment.both,
          originalPrice: 12.00,
          price: 5.50,
          expiresAt: now.add(const Duration(hours: 5)),
        ),
      ),
      _MapEntry(
        position: Position(2.3580, 48.8550),
        listing: FoodListing(
          id: 'm3',
          name: 'Buddha bowl végé',
          imagePath: AppImages.foodTest,
          sellerName: 'Green Kitchen',
          category: SellerCategory.restaurant,
          distanceKm: 1.1,
          rating: 4.6,
          reviewCount: 89,
          dietaryTags: const [DietaryTag.vegan, DietaryTag.glutenFree],
          portionsLeft: 2,
          fulfillment: Fulfillment.pickup,
          originalPrice: 11.00,
          price: 4.50,
          expiresAt: now.add(const Duration(hours: 1, minutes: 30)),
        ),
      ),
      _MapEntry(
        position: Position(2.3460, 48.8540),
        listing: FoodListing(
          id: 'm4',
          name: 'Soupe de légumes',
          imagePath: AppImages.foodTest,
          sellerName: 'Chez Anna',
          category: SellerCategory.traiteur,
          distanceKm: 1.0,
          rating: 4.7,
          reviewCount: 18,
          portionsLeft: 2,
          fulfillment: Fulfillment.both,
          price: 4,
          expiresAt: now.add(const Duration(hours: 1)),
        ),
      ),
      _MapEntry(
        position: Position(2.3560, 48.8620),
        listing: FoodListing(
          id: 'm5',
          name: 'Quiche lorraine',
          imagePath: AppImages.foodTest,
          sellerName: 'Marc',
          category: SellerCategory.faitMaison,
          distanceKm: 0.5,
          rating: 4.8,
          reviewCount: 12,
          portionsLeft: 1,
          fulfillment: Fulfillment.pickup,
          price: 2.50,
          expiresAt: now.add(const Duration(hours: 3)),
        ),
      ),
      _MapEntry(
        position: Position(2.3440, 48.8595),
        listing: FoodListing(
          id: 'm6',
          name: 'Tarte aux pommes',
          imagePath: AppImages.foodTest,
          sellerName: 'Boulangerie Paul',
          category: SellerCategory.restaurant,
          distanceKm: 0.7,
          rating: 4.6,
          reviewCount: 41,
          portionsLeft: 3,
          fulfillment: Fulfillment.pickup,
          price: 2,
          expiresAt: now.add(const Duration(hours: 4)),
        ),
      ),
    ];
  }

  bool _isUrgent(_MapEntry e) =>
      e.listing.expiresAt.difference(DateTime.now()) <= _urgentWindow;

  bool _matchesFilter(_MapEntry e) {
    switch (_selectedFilter) {
      case MapFilter.all:
        return true;
      case MapFilter.social:
        return e.listing.category == SellerCategory.faitMaison;
      case MapFilter.traiteur:
        return e.listing.category == SellerCategory.traiteur;
      case MapFilter.restaurant:
        return e.listing.category == SellerCategory.restaurant;
      case MapFilter.urgent:
        return _isUrgent(e);
    }
  }

  List<_MapEntry> get _visibleEntries =>
      _entries.where(_matchesFilter).toList();

  Future<void> _onMapCreated(MapboxMap map) async {
    _map = map;
    await map.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    await map.setBounds(CameraBoundsOptions(minZoom: 11.0, maxZoom: 18.0));
    await _refreshScreenCoords();
  }

  void _onCameraChange(CameraChangedEventData _) {
    unawaited(_refreshScreenCoords());
  }

  Future<void> _refreshScreenCoords() async {
    if (_map == null) return;
    final gen = ++_projectionGen;
    final visible = _visibleEntries;

    final pinPoints = visible
        .map((e) => Point(coordinates: e.position))
        .toList();
    final userPoint = Point(coordinates: _userLocation);

    final results = await _map!.pixelsForCoordinates([
      ...pinPoints,
      userPoint,
    ]);
    if (gen != _projectionGen || !mounted) return;

    setState(() {
      _pinScreenCoords = results.sublist(0, visible.length);
      _userScreenCoord = results.last;
    });
  }

  void _centerOnUser() {
    _map?.flyTo(
      CameraOptions(
        center: Point(coordinates: _userLocation),
        zoom: _initialZoom,
      ),
      MapAnimationOptions(duration: 600),
    );
  }

  Future<void> _flyToCurrentZoom(Position pos) async {
    if (_map == null) return;
    final state = await _map!.getCameraState();
    await _map!.flyTo(
      CameraOptions(center: Point(coordinates: pos), zoom: state.zoom),
      MapAnimationOptions(duration: 400),
    );
  }

  void _openSheetFor(_MapEntry entry) {
    setState(() => _selectedId = entry.listing.id);
    unawaited(_flyToCurrentZoom(entry.position));

    showBlurredModalBottomSheet<void>(
      context: context,
      builder: (_) => MapListingSheet(
        listing: entry.listing,
        onViewDetail: () => Get.to(() => const ProductDetailScreen()),
        onOrder: () => Get.back<void>(),
      ),
    ).whenComplete(() {
      if (mounted) setState(() => _selectedId = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visibleEntries;
    final styleUri = context.isDark ? MapboxStyles.DARK : MapboxStyles.LIGHT;

    return Scaffold(
      body: Stack(
        children: [
          //* full-screen map
          MapWidget(
            styleUri: styleUri,
            cameraOptions: CameraOptions(
              center: Point(coordinates: _userLocation),
              zoom: _initialZoom,
            ),
            onMapCreated: _onMapCreated,
            onCameraChangeListener: _onCameraChange,
          ),

          //* user location dot — anchored at the projected screen point
          if (_userScreenCoord != null)
            Positioned(
              left: _userScreenCoord!.x - _userDotSize / 2,
              top: _userScreenCoord!.y - _userDotSize / 2,
              width: _userDotSize,
              height: _userDotSize,
              child: const _UserLocationDot(),
            ),

          //* food pins — top-center anchored at the projected screen point,
          //* matching the original flutter_map alignment.
          for (var i = 0; i < visible.length; i++)
            if (i < _pinScreenCoords.length && _pinScreenCoords[i] != null)
              Positioned(
                left: _pinScreenCoords[i]!.x - _pinWidth / 2,
                top: _pinScreenCoords[i]!.y,
                width: _pinWidth,
                height: _pinHeight,
                child: MapPin(
                  listing: visible[i].listing,
                  isSelected: _selectedId == visible[i].listing.id,
                  isUrgent: _isUrgent(visible[i]),
                  onTap: () => _openSheetFor(visible[i]),
                ),
              ),

          //* top: back button + filter bar
          Align(
            alignment: Alignment.topCenter,
            child: _TopSection(
              selectedFilter: _selectedFilter,
              onFilterSelect: (f) {
                setState(() => _selectedFilter = f);
                unawaited(_refreshScreenCoords());
              },
            ),
          ),

          //* center-on-user FAB
          Positioned(
            right: AppSizes.md,
            bottom: AppSizes.md,
            child: SafeArea(child: CenterOnUserButton(onTap: _centerOnUser)),
          ),
        ],
      ),
    );
  }
}

class _TopSection extends StatelessWidget {
  const _TopSection({
    required this.selectedFilter,
    required this.onFilterSelect,
  });

  final MapFilter selectedFilter;
  final ValueChanged<MapFilter> onFilterSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomAppBar(showBackArrow: true),
        const Gap(AppSizes.sm),
        MapFilterBar(selected: selectedFilter, onSelect: onFilterSelect),
      ],
    );
  }
}

class _MapEntry {
  const _MapEntry({required this.position, required this.listing});

  final Position position;
  final FoodListing listing;
}

class _UserLocationDot extends StatelessWidget {
  const _UserLocationDot();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.20),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: scheme.primary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
