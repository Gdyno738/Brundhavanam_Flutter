
import 'package:flutter/material.dart';

import '../../data/dummy_products.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/common/base_screen.dart';
import '../../ui/widgets/home_search_bar.dart';
import '../../ui/widgets/product_card.dart';
import '../location/location_header.dart';
import '../navigation/main_navigation.dart';

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

    return BaseScreen(
      child: Column(
        children: [
          LocationHeader(
            title: category,
            subtitle: '',
            showBack: true,
            showDropdown: false,
            onBack: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const MainNavigation(initialIndex: 0),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 320, // 🔥 FIXED (no overflow)
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


