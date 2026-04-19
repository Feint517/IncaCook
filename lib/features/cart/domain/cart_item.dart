class CartItem {
  CartItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    this.quantity = 1,
  });

  final String id;
  final String name;
  final String description;
  final String imagePath;
  final double price;
  int quantity;
}
