import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:incacook/core/config/google_maps_config.dart';
import 'package:incacook/core/constants/sizes.dart';
import 'package:incacook/core/constants/text_strings.dart';
import 'package:incacook/core/models/address.dart';
import 'package:incacook/core/services/location/location_service.dart';
import 'package:incacook/core/services/map/address_mapping.dart';
import 'package:incacook/core/services/map/google_places_client.dart';
import 'package:incacook/core/services/map/models/map_route.dart';
import 'package:incacook/core/services/map/models/place_suggestion.dart';
import 'package:incacook/core/utils/theme/theme_extensions.dart';

/// Reusable Google Places address picker with autocomplete, current location,
/// and map preview.
///
/// Features:
/// - Single search field with Google Places autocomplete (debounced)
/// - "Use my current location" button that reverse-geocodes GPS
/// - Map preview with pin when address is selected
/// - Returns complete [Address] with street + postal code + city + coordinate
///
/// Used by:
/// - Client saved addresses (Settings → My Addresses)
/// - Seller/restaurant address (onboarding)
/// - Delivery address (checkout)
///
/// Example:
/// ```dart
/// GoogleMapAddressPicker(
///   value: _address,
///   onChanged: (address) => setState(() => _address = address),
///   hint: 'Entrez votre adresse',
/// )
/// ```
class GoogleMapAddressPicker extends StatefulWidget {
  const GoogleMapAddressPicker({
    super.key,
    required this.onChanged,
    this.value,
    this.hint = 'Rechercher une adresse',
    this.country = 'FR',
    this.language = 'fr',
    this.showMapPreview = true,
    this.showCurrentLocationButton = true,
    this.mapPreviewHeight = 140,
  });

  /// Current selected address. Displayed in the field and with map preview.
  final Address? value;

  /// Callback when an address is selected or cleared.
  final ValueChanged<Address?> onChanged;

  /// Search field hint text.
  final String hint;

  /// Country code for Places autocomplete (e.g., 'FR' for France).
  final String country;

  /// Language code for Places results (e.g., 'fr' for French).
  final String language;

  /// Whether to show the static map preview when address is selected.
  final bool showMapPreview;

  /// Whether to show the "Use my current location" button.
  final bool showCurrentLocationButton;

  /// Height of the map preview widget.
  final double mapPreviewHeight;

  @override
  State<GoogleMapAddressPicker> createState() => _GoogleMapAddressPickerState();
}

class _GoogleMapAddressPickerState extends State<GoogleMapAddressPicker> {
  static const Duration _debounce = Duration(milliseconds: 350);

  final GooglePlacesClient _placesClient = Get.find<GooglePlacesClient>();
  final LocationService _locationService = Get.find<LocationService>();
  late final TextEditingController _controller;
  late final String _sessionToken = _placesClient.newSessionToken();

  Timer? _debounceTimer;
  int _queryGen = 0;
  List<PlaceSuggestion> _suggestions = const [];
  bool _searching = false;
  bool _locating = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value?.fullAddress ?? '');
  }

  @override
  void didUpdateWidget(GoogleMapAddressPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync controller when value changes externally (e.g., form reset)
    if (oldWidget.value?.fullAddress != widget.value?.fullAddress &&
        widget.value?.fullAddress != _controller.text) {
      _controller.text = widget.value?.fullAddress ?? '';
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    _debounceTimer?.cancel();
    if (query.trim().isEmpty) {
      setState(() {
        _suggestions = const [];
        _searching = false;
        _error = null;
      });
      widget.onChanged(null);
      return;
    }
    _debounceTimer = Timer(_debounce, () => _runSuggest(query));
  }

  Future<void> _runSuggest(String query) async {
    final gen = ++_queryGen;
    setState(() {
      _searching = true;
      _error = null;
    });
    try {
      final results = await _placesClient.suggest(
        query: query,
        sessionToken: _sessionToken,
        language: widget.language,
        country: widget.country,
      );
      if (gen != _queryGen || !mounted) return;
      // Float precise street addresses (which carry a postcode) above coarser
      // place/locality results, keeping provider relevance order within each.
      final ordered = [
        ...results.where((s) => s.featureType == 'address'),
        ...results.where((s) => s.featureType != 'address'),
      ];
      setState(() {
        _suggestions = ordered;
        _searching = false;
      });
    } catch (_) {
      if (gen != _queryGen || !mounted) return;
      setState(() {
        _searching = false;
        _error = AppTexts.signupAddressSearchError;
      });
    }
  }

  Future<void> _selectSuggestion(PlaceSuggestion suggestion) async {
    setState(() {
      _searching = true;
      _suggestions = const [];
      _error = null;
    });
    try {
      final place = await _placesClient.retrieve(
        placeId: suggestion.placeId,
        sessionToken: _sessionToken,
      );
      if (!mounted) return;
      _commitAddress(addressFromRetrievedPlace(place));
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _searching = false;
        _error = AppTexts.signupAddressSearchError;
      });
    }
  }

  Future<void> _useCurrentLocation() async {
    setState(() {
      _locating = true;
      _error = null;
    });
    try {
      final pos = await _locationService.getCurrent();
      if (pos == null) {
        if (!mounted) return;
        setState(() {
          _locating = false;
          _error = AppTexts.signupAddressLocationDenied;
        });
        return;
      }
      final place = await _placesClient.reverse(
        lat: pos.latitude,
        lng: pos.longitude,
        language: widget.language,
      );
      if (!mounted) return;
      _commitAddress(addressFromRetrievedPlace(place));
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _locating = false;
        _error = AppTexts.signupAddressLocationError;
      });
    }
  }

  /// Applies the chosen [address] to the field + parent, clearing transient UI.
  void _commitAddress(Address address) {
    _controller.text = address.fullAddress;
    setState(() {
      _suggestions = const [];
      _searching = false;
      _locating = false;
    });
    widget.onChanged(address);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search field with loading indicator.
        _SearchField(
          controller: _controller,
          hint: widget.hint,
          searching: _searching,
          errorText: _error,
          onChanged: _onQueryChanged,
        ),
        const Gap(AppSizes.sm),

        // "Use my current location" button.
        if (widget.showCurrentLocationButton)
          _CurrentLocationButton(
            locating: _locating,
            onPressed: _useCurrentLocation,
          ),

        // Autocomplete suggestions dropdown.
        if (_suggestions.isNotEmpty) ...[
          const Gap(AppSizes.sm),
          _SuggestionsList(
            suggestions: _suggestions,
            onSelect: _selectSuggestion,
          ),
        ],

        // Map preview when address is selected.
        if (widget.showMapPreview && widget.value != null) ...[
          const Gap(AppSizes.sm + 4),
          _MapPreview(
            address: widget.value!,
            height: widget.mapPreviewHeight,
          ),
        ],
      ],
    );
  }
}

/// Search field with autocomplete and loading state.
class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.hint,
    required this.searching,
    required this.errorText,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final bool searching;
  final String? errorText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasError = errorText != null;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(Iconsax.search_normal, color: scheme.primary),
        suffixIcon: searching
            ? const Padding(
                padding: EdgeInsets.all(AppSizes.md),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : null,
        filled: true,
        errorText: hasError ? errorText : null,
      ),
    );
  }
}

/// "Use my current location" button.
class _CurrentLocationButton extends StatelessWidget {
  const _CurrentLocationButton({
    required this.locating,
    required this.onPressed,
  });

  final bool locating;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: locating ? null : onPressed,
        icon: locating
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(Iconsax.gps, size: 18, color: scheme.primary),
        label: Text(
          locating
              ? AppTexts.signupAddressLocating
              : AppTexts.signupAddressUseCurrentLocation,
          style: textTheme.bodyMedium,
        ),
      ),
    );
  }
}

/// Autocomplete suggestions dropdown.
class _SuggestionsList extends StatelessWidget {
  const _SuggestionsList({
    required this.suggestions,
    required this.onSelect,
  });

  final List<PlaceSuggestion> suggestions;
  final ValueChanged<PlaceSuggestion> onSelect;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: suggestions
            .map(
              (s) => InkWell(
                onTap: () => onSelect(s),
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.sm + 4),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.location,
                        size: 18,
                        color: scheme.onSurfaceVariant,
                      ),
                      const Gap(AppSizes.sm + 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s.name,
                              style: TextStyle(color: scheme.onSurface),
                            ),
                            if (s.placeFormatted.isNotEmpty)
                              Text(
                                s.placeFormatted,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: scheme.onSurfaceVariant,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

/// Static map preview with pinned location.
class _MapPreview extends StatelessWidget {
  const _MapPreview({
    required this.address,
    required this.height,
  });

  final Address address;
  final double height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final coordinate = address.coordinate;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Static Google Maps preview.
            if (coordinate != null)
              Image.network(
                _staticMapUrl(coordinate, dark: context.isDark),
                fit: BoxFit.cover,
                loadingBuilder: (ctx, child, progress) =>
                    progress == null ? child : _placeholder(scheme),
                errorBuilder: (_, _, _) => _placeholder(scheme),
              )
            else
              _placeholder(scheme),

            // "Confirmed" chip pinned bottom-left.
            Positioned(
              left: AppSizes.sm,
              bottom: AppSizes.sm,
              child: _ConfirmationChip(scheme: scheme),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a Google Static Maps URL centered on [c].
  String _staticMapUrl(MapPoint c, {required bool dark, int width = 640}) {
    const zoom = 15;
    final style = dark
        ? '&style=element:geometry|color:0x242f3e'
            '&style=element:labels.text.fill|color:0x746855'
            '&style=element:labels.text.stroke|color:0x242f3e'
        : '';
    return 'https://maps.googleapis.com/maps/api/staticmap'
        '?center=${c.lat},${c.lng}'
        '&zoom=$zoom'
        '&size=${width}x280'
        '&scale=2'
        '&markers=color:green%7C${c.lat},${c.lng}'
        '$style'
        '&key=${GoogleMapsConfig.apiKey}';
  }

  /// Fallback placeholder while map loads or on error.
  Widget _placeholder(ColorScheme scheme) {
    return Container(
      color: scheme.surfaceContainerHigh,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.location_tick, color: scheme.primary, size: 32),
          const Gap(AppSizes.xs + 2),
          Text(
            AppTexts.signupAddressConfirmed,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

/// "Address confirmed" chip overlay on map preview.
class _ConfirmationChip extends StatelessWidget {
  const _ConfirmationChip({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.sm + 2,
        vertical: AppSizes.xs + 1,
      ),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Iconsax.location_tick,
            color: scheme.primary,
            size: 16,
          ),
          const Gap(AppSizes.xs + 2),
          Text(
            AppTexts.signupAddressConfirmed,
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
