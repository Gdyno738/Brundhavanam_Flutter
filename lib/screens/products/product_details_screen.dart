import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../ui/common/app_colors.dart';
import '../home/sections/location_header.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// 🔝 HEADER — PRODUCT TITLE
          SafeArea(
            bottom: false,
            child: LocationHeader(
              title: product.title, // ✅ FIXED
              subtitle: '',
              showBack: true,
              showDropdown: false,
              onBack: () => Navigator.pop(context),
            ),
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
                      product.image, // ✅ FIXED
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 🐄 PRODUCT NAME
                  Text(
                    product.title, // ✅ FIXED
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// ⭐ RATING + PRICE
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toString(), // ✅ FIXED
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Spacer(),
                      Text(
                        '₹${product.price}', // ✅ FIXED
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// ℹ️ DESCRIPTION
                  Text(
                    product.description, // ✅ FIXED
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: AppColors.grey,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// 🛒 ADD TO CART
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        debugPrint('Add to cart');
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
