class Product {
  final String image;
  final String title;
  final String description;
  final String size;
  final double price;
  final double originalPrice;
  final String category;
  final double rating;

  Product({
    required this.image,
    required this.title,
    required this.description,
    required this.size,
    required this.price,
    required this.rating,
    required this.originalPrice,
    required this.category,
  });

  /// 🔑 IMPORTANT FOR CART QUANTITY
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.title == title &&
        other.price == price &&
        other.category == category;
  }

  @override
  int get hashCode =>
      title.hashCode ^ price.hashCode ^ category.hashCode;
}
