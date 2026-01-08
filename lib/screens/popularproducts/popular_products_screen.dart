import 'package:flutter/material.dart';

import '../../../data/dummy_products.dart';
import '../../../ui/common/app_colors.dart';
import '../../../ui/widgets/category_horizontal_list.dart';
import '../../../ui/widgets/home_search_bar.dart';
import '../../../ui/widgets/product_card.dart';
import '../home/sections/location_header.dart';

class MostPopularProductsScreen extends StatefulWidget {
  const MostPopularProductsScreen({super.key});

  @override
  State<MostPopularProductsScreen> createState() =>
      _MostPopularProductsScreenState();
}

class _MostPopularProductsScreenState
    extends State<MostPopularProductsScreen> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// 🔝 HEADER
          LocationHeader(
            title: 'Most Popular Products',
            subtitle: '',
            showBack: true,
            showDropdown: false,
            onBack: () => Navigator.pop(context), // ✅ FIX
          ),

          const SizedBox(height: 12),
          const HomeSearchBar(),
          const SizedBox(height: 12),

          /// 🏷 CATEGORY FILTER
          CategoryHorizontalList(
            selectedCategory: selectedCategory ?? 'ALL',
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category == 'ALL' ? null : category;
              });
            },
          ),

          const SizedBox(height: 16),

          /// 🧺 PRODUCTS GRID
          Expanded(child: _buildProductsGrid()),
        ],
      ),
    );
  }

  Widget _buildProductsGrid() {
    final products = selectedCategory == null
        ? popularProducts
        : popularProducts
        .where((p) => p.category == selectedCategory)
        .toList();

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (_, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
