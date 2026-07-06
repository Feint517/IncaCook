import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:incacook/core/common/widgets/appbar/appbar.dart';
import 'package:incacook/core/constants/sizes.dart';
import 'package:incacook/core/utils/popups/blurred_modal_sheet.dart';
import 'package:incacook/features/catalog/presentation/screens/product_detail.dart';
import 'package:incacook/features/map/controllers/map_controller.dart';
import 'package:incacook/features/map/domain/map_entry.dart';
import 'package:incacook/features/map/presentation/widget/center_on_user_button.dart';
import 'package:incacook/features/map/presentation/widget/map_filter_bar.dart';
import 'package:incacook/features/map/presentation/widget/map_listing_sheet.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  void _openSheetFor(BuildContext context, MapEntry entry) {
    final controller = MapController.instance;
    controller.setSelected(entry.listing.id);
    unawaited(controller.flyToCurrentZoom(entry.position));

    showBlurredModalBottomSheet<void>(
      context: context,
      builder: (_) => MapListingSheet(
        listing: entry.listing,
        // Open the real backend record this pin was built from.
        onViewDetail: () =>
            Get.to(() => ProductDetailScreen(listing: entry.source)),
        onOrder: () => Get.back<void>(),
      ),
    ).whenComplete(() => controller.setSelected(null));
  }

  @override
  Widget build(BuildContext context) {
    final controller = MapController.instance;

    return Scaffold(
      appBar: const CustomAppBar(showBackArrow: true),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          //* full-screen map
          Obx(() {
            final user = controller.userLocation.value;
            final markers = <Marker>{
              Marker(
                markerId: const MarkerId('user'),
                position: LatLng(user.lat, user.lng),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure,
                ),
              ),
              for (final entry in controller.visibleEntries)
                Marker(
                  markerId: MarkerId(entry.listing.id),
                  position: LatLng(entry.position.lat, entry.position.lng),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    controller.selectedId.value == entry.listing.id
                        ? BitmapDescriptor.hueGreen
                        : controller.isUrgent(entry)
                            ? BitmapDescriptor.hueOrange
                            : BitmapDescriptor.hueRed,
                  ),
                  onTap: () => _openSheetFor(context, entry),
                ),
            };
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(user.lat, user.lng),
                zoom: MapController.initialZoom,
              ),
              markers: markers,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              onMapCreated: controller.onMapCreated,
            );
          }),

          //* top: filter bar — pushed below the (transparent) appbar since
          //* extendBodyBehindAppBar puts y=0 at the screen top.
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.viewPaddingOf(context).top +
                    AppSizes.appBarHeight +
                    AppSizes.sm,
              ),
              child: Obx(
                () => MapFilterBar(
                  selected: controller.selectedFilter.value,
                  onSelect: controller.setFilter,
                ),
              ),
            ),
          ),

          //* center-on-user FAB
          Positioned(
            right: AppSizes.md,
            bottom: AppSizes.md,
            child: SafeArea(
              child: CenterOnUserButton(onTap: controller.centerOnUser),
            ),
          ),
        ],
      ),
    );
  }
}
