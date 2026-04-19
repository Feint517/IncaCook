class FoodOffer {
  const FoodOffer({
    required this.titleLeading,
    required this.titleTrailing,
    required this.imagePath,
    required this.deliveryMinutes,
    required this.price,
    required this.weightGrams,
    required this.calories,
    required this.containOffers,
    this.discountLabel,
    this.freeDelivery = true,
  });

  final String titleLeading;
  final String titleTrailing;
  final String imagePath;
  final int deliveryMinutes;
  final double price;
  final int weightGrams;
  final int calories;
  final bool containOffers;
  final String? discountLabel;
  final bool freeDelivery;
}
