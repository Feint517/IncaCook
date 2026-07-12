import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:incacook/core/constants/sizes.dart';
import 'package:incacook/core/models/listing.dart';
import 'package:incacook/core/models/listing_mappers.dart';
import 'package:incacook/features/catalog/data/models/requests/list_listings_query.dart';
import 'package:incacook/features/catalog/data/repositories/listings_repository.dart';
import 'package:incacook/features/catalog/presentation/screens/product_detail.dart';
import 'package:incacook/features/client/presentation/widget/food_listing_card.dart';

/// Loads the seller's currently orderable listings. Returns the [Listing]s
/// already scoped to one seller — the default implementation fetches the
/// buyer feed and filters client-side (see [SellerMenuSection]).
typedef SellerMenuLoader = Future<List<Listing>> Function();

/// "Ses plats" — the seller's orderable listings, rendered on the
/// buyer-facing seller profile so the profile is no longer a read-only
/// dead-end. Each card taps through to [ProductDetailScreen], the exact
/// same orderable path the home feed uses (`FoodListingCard` +
/// `Get.to(ProductDetailScreen(listing:))`).
///
/// Sourcing: the backend feed (`GET /v1/listings`) has **no `sellerId`
/// filter** today (see `list-feed-query.dto.ts`), so the default loader
/// pulls the visible feed and keeps only this seller's items client-side.
/// A `?sellerId=` param should be added server-side for efficiency. Because
/// only feed-visible listings are surfaced, sold-out / unavailable / expired
/// entries are naturally excluded — exactly what a buyer can order.
class SellerMenuSection extends StatefulWidget {
  const SellerMenuSection({super.key, required this.sellerId, this.loader});

  final String sellerId;

  /// Injectable loader (tests). Defaults to feed-fetch + client-side filter.
  final SellerMenuLoader? loader;

  @override
  State<SellerMenuSection> createState() => _SellerMenuSectionState();
}

class _SellerMenuSectionState extends State<SellerMenuSection> {
  late final SellerMenuLoader _loader = widget.loader ?? _defaultLoader;

  List<Listing> _plats = const [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  /// Pulls the buyer feed (max page) and keeps only this seller's listings.
  /// Pragmatic fallback until the feed supports `?sellerId=`.
  Future<List<Listing>> _defaultLoader() async {
    final result = await ListingsRepository().getFeed(
      const ListListingsQuery(limit: 100),
    );
    return result.items
        .where((l) => l.sellerId == widget.sellerId)
        .toList(growable: false);
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final plats = await _loader();
      if (!mounted) return;
      setState(() {
        _plats = plats;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ses plats', style: Theme.of(context).textTheme.titleMedium),
        const Gap(AppSizes.md),
        _buildBody(context),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.lg),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, size: 36),
              const Gap(AppSizes.sm),
              ElevatedButton(
                onPressed: _load,
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      );
    }
    if (_plats.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
        child: Text(
          'Aucun plat disponible pour le moment',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      );
    }
    // Full-width cards stacked vertically. We're inside the profile's
    // SingleChildScrollView, so a plain Column (not a nested scrollable)
    // avoids nested-scroll conflicts.
    return Column(
      children: [
        for (var i = 0; i < _plats.length; i++) ...[
          if (i > 0) const Gap(AppSizes.md),
          SizedBox(
            height: 200,
            child: FoodListingCard(
              listing: _plats[i].toFoodListing(),
              onTap: () =>
                  Get.to(() => ProductDetailScreen(listing: _plats[i])),
            ),
          ),
        ],
      ],
    );
  }
}
