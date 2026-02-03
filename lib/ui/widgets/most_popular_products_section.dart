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
        /// 🔥 HEADER
        SectionHeader(
          title: 'Most Popular Products',
          onViewAll: onViewAll, // ✅ delegated (CORRECT)
        ),

        const SizedBox(height: 12),

        /// 🛒 PRODUCTS LIST
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.48,
        //   child: ListView.separated(
        //     scrollDirection: Axis.horizontal,
        //     padding: const EdgeInsets.symmetric(horizontal: 16),
        //     itemCount: popularProducts.length,
        //     separatorBuilder: (_, __) => const SizedBox(width: 20),
        //     itemBuilder: (_, index) {
        //       return SizedBox(
        //         width: 185,
        //         child: ProductCard(
        //           product: popularProducts[index],
        //         ),
        //       );
        //     },
        //   ),
        // ),

        SizedBox(
          height: 335,
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
