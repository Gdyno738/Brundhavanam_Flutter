class Product {
  final String id; // ✅ NEW
  final String image;
  final String title;
  final String description;
  final String size;
  final double price;
  final double originalPrice;
  final String category;
  final double rating;

  Product({
    required this.id, // ✅ NEW
    required this.image,
    required this.title,
    required this.description,
    required this.size,
    required this.price,
    required this.originalPrice,
    required this.category,
    required this.rating,
  });
}
