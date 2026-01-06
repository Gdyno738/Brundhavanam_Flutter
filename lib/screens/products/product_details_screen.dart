import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/common/base_screen.dart';
import '../../ui/widgets/about_us_section.dart';
import '../../ui/widgets/most_popular_products_section.dart';
import '../home/sections/location_header.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String selectedSize = '1 liter';

  final List<String> sizes = [
    '500 ml',
    '1 liter',
    '2 liter',
    'Custom quantity',
  ];

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return BaseScreen(
      child: Column(
        children: [
        LocationHeader(
              title: product.title,
              subtitle: '',
              showBack: true,
              showDropdown: false,
              onBack: () => Navigator.pop(context),
            ),


          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🖼 PRODUCT IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      product.image,
                      height: 261,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 🐄 NAME + SIZE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      _sizeDropdown(),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// 💰 PRICE + RATING
                  Row(
                    children: [
                      Text(
                        '₹${product.originalPrice}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '₹${product.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// ℹ️ DESCRIPTION
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: AppColors.grey,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// 🛒 ADD TO CART BUTTON
                  Consumer<CartProvider>(
                    builder: (context, cart, _) {
                      final isInCart = cart.isInCart(product);
                      final qty = cart.quantity(product);

                      /// 🛒 IF NOT IN CART → ADD TO CART
                      if (!isInCart) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              cart.addToCart(product);
                            },
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        );
                      }

                      /// ➖ qty ➕ IF ALREADY IN CART
                      return Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// ➖
                            IconButton(
                              onPressed: () => cart.decrease(product),
                              icon: const Icon(Icons.remove, color: Colors.white),
                            ),

                            /// QTY
                            Text(
                              qty.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            /// ➕
                            IconButton(
                              onPressed: () => cart.increase(product),
                              icon: const Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  /// 🧾 ABOUT US
                  const AboutUsSection(),

                  const SizedBox(height: 24),

                  /// 🔥 MOST POPULAR PRODUCTS
                  const MostPopularProductsSection(),


                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔽 SIZE DROPDOWN
  Widget _sizeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD6D6D6)),
      ),
      child: DropdownButton<String>(
        value: selectedSize,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: sizes.map((size) {
          return DropdownMenuItem(
            value: size,
            child: Text(
              size,
              style: const TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() => selectedSize = value!);
        },
      ),
    );
  }
}
