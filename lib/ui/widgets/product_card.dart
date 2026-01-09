import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ui/widgets/ProductSizeBadge.dart';


import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wish_list_provider.dart';
import '../../screens/navigation/main_navigation.dart';
import '../../screens/products/product_details_screen.dart';
import '../../screens/products/products_screen.dart';
import '../common/app_colors.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product),
          ),
        );

        if (result == 'VIEW_ALL_PRODUCTS') {
          MainNavigation.navKey.currentState?.switchTab(2);
        }
      },

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
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),

                    /// SIZE
                    Text(
                      product.size,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.primary,
                      ),
                    ),

                    /// TITLE
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

                    /// DESCRIPTION
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

                    /// 🟢 CATEGORY (QUICK LINK BEHAVIOR)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductsScreen(
                              initialCategory: product.category, // ✅ pass category
                            ),
                          ),
                        );
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

                    const Spacer(),

                    /// PRICE
                    Row(
                      children: [
                        Text(
                          '₹${product.originalPrice}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.grey,
                            decoration: TextDecoration.lineThrough,
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

                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ),

            /// 🛒 ADD TO CART
            Consumer<CartProvider>(
              builder: (_, cart, __) {
                final inCart = cart.isInCart(product);

                if (!inCart) {
                  return GestureDetector(
                    onTap: () => cart.addToCart(product),
                    child: Container(
                      height: 44,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }

                return Container(
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.white),
                        onPressed: () => cart.decrease(product),
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
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () => cart.increase(product),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
