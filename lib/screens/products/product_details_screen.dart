import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/common/base_screen.dart';
import '../../ui/widgets/about_us_section.dart';
import '../../ui/widgets/most_popular_products_section.dart';
import '../home/sections/location_header.dart';

import '../popularproducts/popular_products_screen.dart';

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
          /// 🔝 HEADER
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

                  /// 🐄 TITLE + SIZE
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

                  const SizedBox(height: 8),

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
                      height: 1.5,
                      color: AppColors.grey,
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// 🛒 ADD TO CART / QUANTITY
                  Consumer<CartProvider>(
                    builder: (_, cart, __) {
                      final isInCart = cart.isInCart(product);
                      final qty = cart.quantity(product);

                      /// ADD TO CART
                      if (!isInCart) {
                        return SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () => cart.addToCart(product),
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

                      /// ➖➕ QUANTITY CONTROLLER (IMPROVED UI)
                      return Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _qtyButton(
                              icon: Icons.remove,
                              onTap: () => cart.decrease(product),
                            ),

                            Text(
                              qty.toString(),
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            _qtyButton(
                              icon: Icons.add,
                              onTap: () => cart.increase(product),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 28),

                  /// 🧾 ABOUT US
                  const AboutUsSection(),

                  const SizedBox(height: 24),

                  /// 🔥 MOST POPULAR

                  MostPopularProductsSection(
                    onViewAll: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MostPopularProductsScreen(),
                        ),
                      );
                    },
                  ),




                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔽 SIZE DROPDOWN (THEMED)
  Widget _sizeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedSize,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.black,
          ),
          dropdownColor: AppColors.white, // ✅ dropdown background
          borderRadius: BorderRadius.circular(14), // ✅ rounded popup
          items: sizes.map((size) {
            return DropdownMenuItem<String>(
              value: size,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 6,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_drink,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      size,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => selectedSize = value!);
          },
        ),
      ),
    );
  }


  /// ➖➕ ROUND BUTTON
  Widget _qtyButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 56,
        height: 52,
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: AppColors.white,
          size: 22,
        ),
      ),
    );
  }
}
