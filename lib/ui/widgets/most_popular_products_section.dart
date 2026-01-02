import 'package:flutter/material.dart';
import '../../data/dummy_products.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';

class MostPopularProductsSection extends StatelessWidget {
  const MostPopularProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// HEADER
        SectionHeader(
          title: 'Most Popular Product',
          onViewAll: () {
            debugPrint('View all popular products');
          },
        ),

        const SizedBox(height: 12),

        /// PRODUCT LIST
        SizedBox(
          height: 330,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: popularProducts.length,
            separatorBuilder: (_, _) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              return ProductCard(
                product: popularProducts[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
