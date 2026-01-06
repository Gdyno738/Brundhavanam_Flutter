import 'package:flutter/material.dart';
import '../../data/dummy_products.dart';
import '../../screens/navigation/main_navigation.dart';

import '../widgets/product_card.dart';
import '../widgets/section_header.dart';

class MostPopularProductsSection extends StatelessWidget {
  const MostPopularProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Most Popular Products',
          onViewAll: () {MainNavigation.navKey.currentState?.switchTab(2);},
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 330, // ✅ correct height
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: popularProducts.length,
            separatorBuilder: (_, __) => const SizedBox(width: 20),
            itemBuilder: (_, index) {
              return SizedBox(
                width: 185, // ✅ THIS FIXES EVERYTHING
                child: ProductCard(
                  product: popularProducts[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
