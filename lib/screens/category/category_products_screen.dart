
import 'package:flutter/material.dart';

import '../../data/dummy_products.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/widgets/home_search_bar.dart';
import '../../ui/widgets/product_card.dart';
import '../home/sections/location_header.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;

  const CategoryProductsScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final filteredProducts = popularProducts
        .where((p) => p.category == category)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// HEADER → CATEGORY NAME
          SafeArea(
            bottom: false,
            child: LocationHeader(
              title: category, // 👈 Selected category name
              subtitle: '',
              showBack: true,
              showDropdown: false,
              onBack: () => Navigator.pop(context),
            ),
          ),


          const SizedBox(height: 12),

          /// SEARCH (REUSED)
          const HomeSearchBar(),

          const SizedBox(height: 16),

          /// PRODUCTS OF THIS CATEGORY
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredProducts.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (_, index) {
                return ProductCard(
                  product: filteredProducts[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
