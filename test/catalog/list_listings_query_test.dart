import 'package:flutter_test/flutter_test.dart';

import 'package:incacook/features/catalog/data/models/requests/list_listings_query.dart';

void main() {
  group('ListListingsQuery.toQueryParameters', () {
    test('emits sellerId when scoping the feed to one seller', () {
      final params = const ListListingsQuery(
        sellerId: 'seller-42',
        limit: 100,
      ).toQueryParameters();

      expect(params['sellerId'], 'seller-42');
      expect(params['limit'], 100);
    });

    test('omits sellerId when it is null', () {
      final params = const ListListingsQuery(limit: 20).toQueryParameters();

      expect(params.containsKey('sellerId'), isFalse);
    });

    test('omits sellerId when it is an empty string', () {
      final params = const ListListingsQuery(sellerId: '').toQueryParameters();

      expect(params.containsKey('sellerId'), isFalse);
    });
  });
}
