import 'package:flutter/material.dart';

import '../../data/dummy_products.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';

import 'package:flutter/material.dart';

import '../../data/dummy_products.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';

class MostPopularProductsSection extends StatelessWidget {
  final VoidCallback onViewAll;

  const MostPopularProductsSection({
    super.key,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Most Popular Products',
          onViewAll: onViewAll,
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 320, // ✅ increased to prevent overflow
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: popularProducts.length,
            separatorBuilder: (_, __) => const SizedBox(width: 20),
            itemBuilder: (_, index) {
              return SizedBox(
                width: 185,
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
