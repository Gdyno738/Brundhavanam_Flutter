import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wish_list_provider.dart';
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
    return MouseRegion(
      opaque: false,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailsScreen(product: product),
            ),
          );
        },
          child:LayoutBuilder(
              builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 0,
                    maxHeight: double.infinity,
                  ),
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
              /// 🖼 IMAGE (FIXED HEIGHT – FILLED)
              SizedBox(
                height: 180, // ✅ stable height (key fix)
                width: double.infinity,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(
                        product.image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover, // ✅ FILLS like before
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),

                    /// 🔖 WISHLIST ICON
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
                                    color: Colors.black26,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Icon(
                                isWishlisted
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                size: 20,
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 6),

              /// SIZE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  product.size,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.primary,
                  ),
                ),
              ),

              /// TITLE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              /// DESCRIPTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              /// PRICE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
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
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),


              /// ADD TO CART
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
                          icon:
                          const Icon(Icons.remove, color: Colors.white),
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
          ),
        ),
    );
  }
}
