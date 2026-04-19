class Brand {
  const Brand({
    required this.name,
    required this.imagePath,
    required this.tagline,
    required this.rating,
    required this.minDeliveryMinutes,
    required this.maxDeliveryMinutes,
  });

  final String name;
  final String imagePath;
  final String tagline;
  final double rating;
  final int minDeliveryMinutes;
  final int maxDeliveryMinutes;
}
