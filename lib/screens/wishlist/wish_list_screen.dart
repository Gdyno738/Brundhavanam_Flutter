import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../ui/common/app_colors.dart';
import '../../providers/wish_list_provider.dart';
import '../../screens/products/product_details_screen.dart';
import '../../ui/common/base_screen.dart';
import '../../ui/widgets/product_card.dart'; // your existing screen

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>();

    return BaseScreen(
      child: Column(
        children: [

          /// 🔹 HEADER
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: 16,
              right: 16,
            ),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFFE7E7E7)),
              ),
            ),
            child: SizedBox(
              height: 56,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: AppColors.black),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Wishlist',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),



          /// 🔹 BODY
          Expanded(
            child: wishlist.items.isEmpty
                ? const Center(
              child: Text(
                'No items in wishlist',
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 16,
                ),
              ),
            )
                : GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
              itemCount: wishlist.items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.57,
              ),
              itemBuilder: (context, index) {
                final product = wishlist.items[index];
                return ProductCard(product: product);
              },
            ),
          ),

        ],
      ),
    );
  }


  Widget _emptyState() {
    return const Center(
      child: Text(
        'No items in wishlist',
        style: TextStyle(
          color: AppColors.grey,
          fontSize: 16,
        ),
      ),
    );
  }
}


class _WishlistCard extends StatelessWidget {
  final Product product;

  const _WishlistCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🖼 PRODUCT IMAGE
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                product.image,
                height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🏷 NAME
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// 💰 PRICE
                  Text(
                    '₹${product.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
