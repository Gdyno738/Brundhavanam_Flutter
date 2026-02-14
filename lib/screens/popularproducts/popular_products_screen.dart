import 'package:brundhavanam_app/ui/common/base_screen.dart';
import 'package:flutter/material.dart';

import '../../../data/dummy_products.dart';
import '../../../data/dummy_reviews.dart';
import '../../../ui/widgets/reviews_horizontal_list.dart';
import '../../../ui/widgets/product_card.dart';
import '../location/location_header.dart';

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
    final products = selectedCategory == null
        ? popularProducts
        : popularProducts
        .where((p) => p.category == selectedCategory)
        .toList();

    return BaseScreen(
      child: Column(
        children: [
          /// 🔝 HEADER
          LocationHeader(
            title: 'Popular Products',
            subtitle: '',
            showBack: true,
            showDropdown: false,
            onBack: () => Navigator.pop(context),
          ),

          /// 🔹 BODY
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  /// 🧺 PRODUCTS GRID
                  GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: products.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 320,
                    ),
                    itemBuilder: (_, index) {
                      return ProductCard(product: products[index]);
                    },
                  ),

                  const SizedBox(height: 20),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
