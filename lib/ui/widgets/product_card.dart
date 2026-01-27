import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wish_list_provider.dart';
import '../../screens/category/category_products_screen.dart';
import '../../screens/navigation/main_navigation.dart';
import '../../screens/products/product_details_screen.dart';
import '../common/app_colors.dart';
import '../widgets/ProductSizeBadge.dart';

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
          border: Border.all(color: AppColors.lightGrey, width: 0.5),
          boxShadow: [
            BoxShadow(color: AppColors.shadow, blurRadius: 8),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      product.image,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 0,
                    right: 0,
                    child: ProductSizeBadge(size: product.size),
                  ),

                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: Consumer<WishlistProvider>(
                      builder: (_, wishlist, __) {
                        final isWishlisted =
                        wishlist.isWishlisted(product);

                        return GestureDetector(
                          onTap: () => wishlist.toggle(product),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26, blurRadius: 4),
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

            /// CONTENT (AUTO HEIGHT)
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.size,
                      style: const TextStyle(
                          fontSize: 10, color: AppColors.primary),
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
                          fontSize: 10, color: AppColors.grey),
                    ),

                    const SizedBox(height: 4),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoryProductsScreen(
                                category: product.category),
                          ),
                        );
                      },
                      child: Text(
                        product.category,
                        style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    const Spacer(),

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
                  ],
                ),
              ),
            ),

            /// ADD TO CART
            Consumer<CartProvider>(
              builder: (_, cart, __) {
                final inCart = cart.isInCart(product);

                return Container(
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16)),
                  ),
                  child: inCart
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove,
                            color: Colors.white),
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
                        icon:
                        const Icon(Icons.add, color: Colors.white),
                        onPressed: () => cart.increase(product),
                      ),
                    ],
                  )
                      : GestureDetector(
                    onTap: () => cart.addToCart(product),
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
    );
  }
}
