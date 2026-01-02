import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../screens/products/product_details_screen.dart';
import '../common/app_colors.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isWishlisted = false;

  void _toggleWishlist() {
    setState(() {
      isWishlisted = !isWishlisted;
    });

    debugPrint(
      isWishlisted
          ? 'Added to wishlist: ${widget.product.title}'
          : 'Removed from wishlist: ${widget.product.title}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// 👉 OPEN PRODUCT DETAILS
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                ProductDetailsScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        width: 185,
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
            /// 🖼 IMAGE + WISHLIST
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    widget.product.image,
                    height: 185,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                /// 🔖 WISHLIST ICON (BOTTOM LEFT)
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent, // ✅ prevents card tap
                    onTap: _toggleWishlist,
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
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// 🧴 SIZE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.product.size,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.primary,
                ),
              ),
            ),

            /// 📝 TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.product.title,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            /// 💬 DESCRIPTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.product.description,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.grey,
                ),
              ),
            ),

            const SizedBox(height: 6),

            /// 💰 PRICE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Text(
                    '₹${widget.product.originalPrice}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '₹${widget.product.price}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// 🛒 ADD TO CART
            Consumer<CartProvider>(
              builder: (context, cart, _) {
                final inCart = cart.isInCart(widget.product);

                if (!inCart) {
                  /// ADD TO CART BUTTON
                  return GestureDetector(
                    onTap: () {
                      cart.addToCart(widget.product);
                    },
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

                /// ➕➖ QUANTITY CONTROLS
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
                        onPressed: () => cart.decrease(widget.product),
                      ),
                      Text(
                        cart.quantity(widget.product).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () => cart.increase(widget.product),
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
