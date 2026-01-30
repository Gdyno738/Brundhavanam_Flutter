
import 'package:flutter/material.dart';

import '../../data/dummy_products.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/common/base_screen.dart';
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

    return BaseScreen(
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: LocationHeader(
              title: category,
              subtitle: '',
              showBack: true,
              showDropdown: false,
              onBack: () => Navigator.pop(context),
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredProducts.length,
              gridDelegate:
              const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.55,
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


