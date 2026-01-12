import '../models/product.dart';

final List<Product> popularProducts = [
  Product(
    id:'milk_001',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpOKQJfpoon8pRe8VS5hmhTY_M8K5nNBC_lQ&s',
    title: 'Low-Fat Buffalo Milk',
    description: 'Fresh, pure cow milk sourced directly from our goshala and handled with care. Naturally light and easy to digest, it is ideal for daily consumption by all age groups.',
    size: '500 ml',
    price: 470,
    originalPrice: 520,
    category: 'Milk',
    rating: 4.7,
  ),

  Product(
    id:'ghee_001',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQg3NdixlXaP4cahCgeflru6uYN87lexCts0Q&s',
    title: 'Pure Cow Ghee',
    description: 'Traditional & aromatic',
    size: '250 ml',
    price: 999,
    originalPrice: 1199,
    category: 'Ghee',
    rating: 4.8,
  ),

  Product(
    id:'curd_001',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTor0w2qoLmzqEJOGm9IP7AwcHPWIA-4K2ivg&s',
    title: 'Fresh Curd',
    description: 'Naturally fermented',
    size: '500 ml',
    price: 120,
    originalPrice: 150,
    category: 'Curd',
    rating: 4.5,
  ),
];
