import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ui/widgets/ProductSizeBadge.dart';


import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wish_list_provider.dart';
import '../../screens/navigation/main_navigation.dart';
import '../../screens/products/product_details_screen.dart';
import '../common/app_colors.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRect( // 🔒 prevents iOS overflow painting
          child: GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsScreen(product: product),
                ),
              );

      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.lightGrey,
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🖼 IMAGE
            SizedBox(
              height: 180,
              width: double.infinity,
              child: Stack(
                children: [
                  /// PRODUCT IMAGE
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // 🔑 iOS safe
                  children: [
                    /// 🖼 IMAGE
                    SizedBox(
                      height: 180,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),

                  /// 🟢 SIZE BADGE (TOP RIGHT)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ProductSizeBadge(
                      size: product.size, // e.g. "500 ml"
                    ),
                  ),

                  /// 🔖 WISHLIST (BOTTOM LEFT)
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: Consumer<WishlistProvider>(
                      builder: (_, wishlist, __) {
                        final isWishlisted = wishlist.isWishlisted(product);

                        return GestureDetector(
                          onTap: () => wishlist.toggle(product),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),


            /// CONTENT
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),

                                return GestureDetector(
                                  onTap: () => wishlist.toggle(product),
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      isWishlisted
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      color: AppColors.primary,
                                      size: 20,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// CONTENT
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            product.size,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.primary,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),

                          Text(
                            product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.grey,
                            ),
                          ),

                          const SizedBox(height: 4),

                          GestureDetector(
                            onTap: () {
                              final navState =
                                  MainNavigation.navKey.currentState;
                              if (navState != null && navState.mounted) {
                                navState.switchTab(
                                  2,
                                  initialCategory: product.category,
                                );
                              }
                            },
                            child: Text(
                              product.category,
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          Row(
                            children: [
                              Text(
                                '₹${product.originalPrice}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.grey,
                                  decoration:
                                  TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '₹${product.price}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// 🛒 ADD TO CART
                    Consumer<CartProvider>(
                      builder: (_, cart, __) {
                        final inCart = cart.isInCart(product);

                        return Container(
                          height: 44,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(16),
                            ),
                          ),
                          child: inCart
                              ? Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove,
                                    color: Colors.white),
                                onPressed: () =>
                                    cart.decrease(product),
                              ),
                              Text(
                                cart.quantity(product).toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add,
                                    color: Colors.white),
                                onPressed: () =>
                                    cart.increase(product),
                              ),
                            ],
                          )
                              : GestureDetector(
                            onTap: () =>
                                cart.addToCart(product),
                            child: const Center(
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
