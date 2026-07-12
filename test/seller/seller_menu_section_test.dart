import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:incacook/core/enums/food_enums.dart';
import 'package:incacook/core/enums/order_enums.dart';
import 'package:incacook/core/models/listing.dart';
import 'package:incacook/features/client/presentation/widget/food_listing_card.dart';
import 'package:incacook/features/seller/presentation/widgets/seller_menu_section.dart';

/// Builds a minimal orderable [Listing]. Uses an http image URL so the card's
/// `Image.network` path is taken (Flutter's test harness stubs it with a
/// transparent image; an asset path would throw).
Listing _listing({required String id, required String sellerId}) => Listing(
  id: id,
  sellerId: sellerId,
  name: 'Plat $id',
  imageUrls: const ['https://example.com/food.png'],
  priceCents: 450,
  portionsLeft: 3,
  category: SellerCategory.faitMaison,
  fulfillment: Fulfillment.pickup,
  prepMinutes: 10,
  createdAt: DateTime(2030),
  updatedAt: DateTime(2030),
);

Widget _host(Widget child) => MaterialApp(
  home: Scaffold(body: SingleChildScrollView(child: child)),
);

void main() {
  testWidgets('renders one card per seller listing', (tester) async {
    await tester.pumpWidget(
      _host(
        SellerMenuSection(
          sellerId: 's1',
          loader: () async => [
            _listing(id: 'a', sellerId: 's1'),
            _listing(id: 'b', sellerId: 's1'),
          ],
        ),
      ),
    );
    // Resolve the loader future + first frame.
    await tester.pump();

    expect(find.text('Ses plats'), findsOneWidget);
    expect(find.byType(FoodListingCard), findsNWidgets(2));
    expect(find.text('Aucun plat disponible pour le moment'), findsNothing);
  });

  testWidgets('shows the empty state when the seller has no listings', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(SellerMenuSection(sellerId: 's1', loader: () async => const [])),
    );
    await tester.pump();

    expect(find.byType(FoodListingCard), findsNothing);
    expect(
      find.text('Aucun plat disponible pour le moment'),
      findsOneWidget,
    );
  });

  testWidgets('shows a retry affordance on load failure', (tester) async {
    await tester.pumpWidget(
      _host(
        SellerMenuSection(
          sellerId: 's1',
          loader: () async => throw Exception('boom'),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Réessayer'), findsOneWidget);
    expect(find.byType(FoodListingCard), findsNothing);
  });
}
