import '../models/product.dart';

final List<Product> popularProducts = [
  Product(
    image: 'https://placehold.co/185x185',
    title: 'Low-Fat Buffalo Milk',
    description: 'Rich taste with reduced fat',
    size: '500 ml',
    price: 470,
    originalPrice: 520,
    category: 'Milk',
    rating: 4.7,
  ),

  Product(
    image: 'https://placehold.co/185x185',
    title: 'Pure Cow Ghee',
    description: 'Traditional & aromatic',
    size: '250 ml',
    price: 999,
    originalPrice: 1199,
    category: 'Ghee',
    rating: 4.8,
  ),

  Product(
    image: 'https://placehold.co/185x185',
    title: 'Fresh Curd',
    description: 'Naturally fermented',
    size: '500 ml',
    price: 120,
    originalPrice: 150,
    category: 'Curd',
    rating: 4.5,
  ),
];
