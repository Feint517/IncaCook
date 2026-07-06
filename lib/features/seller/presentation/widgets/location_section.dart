import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:incacook/core/common/styles/shadows_styles.dart';
import 'package:incacook/core/constants/sizes.dart';
import 'package:incacook/core/constants/text_strings.dart';
import 'package:incacook/core/services/map/models/map_route.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationSection extends StatefulWidget {
  const LocationSection({
    super.key,
    required this.neighborhood,
    required this.profileLocation,
  });

  final String neighborhood;
  final MapPoint profileLocation;

  @override
  State<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  Future<void> _openInMapApp() async {
    final lat = widget.profileLocation.lat;
    final lng = widget.profileLocation.lng;
    // Use Google Maps URL scheme for both iOS and Android
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    final launched = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible d\'ouvrir l\'application de carte')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final position = LatLng(
      widget.profileLocation.lat,
      widget.profileLocation.lng,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.sellerLocationTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Gap(AppSizes.md),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              boxShadow: [CustomShadowStyle.customCircleShadows()],
            ),
            child: GestureDetector(
              onTap: _openInMapApp,
              child: Stack(
                children: [
                  GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: position,
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('seller-location'),
                    position: position,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange,
                    ),
                  ),
                },
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: false,
                  ),
                  // Map tap hint overlay
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Iconsax.map,
                              color: Colors.white,
                              size: 28,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Ouvrir dans Google Maps',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(AppSizes.sm),
        Row(
          children: [
            Icon(
              Iconsax.location,
              size: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
            const Gap(6),
            Text(
              widget.neighborhood,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }
}
