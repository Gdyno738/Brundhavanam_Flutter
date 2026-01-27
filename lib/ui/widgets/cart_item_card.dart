import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../common/app_colors.dart';

class CartItemCard extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7E7E7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          /// DETAILS
          Expanded(
            child: SizedBox(
              height: 90, // increased
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF252525),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// DESCRIPTION
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF595959),
                      fontSize: 10,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// PRICE + QUANTITY
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹ ${product.price.toStringAsFixed(0)}/-',
                        style: const TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: onDecrement,
                              child: const Icon(Icons.remove,
                                  size: 18, color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: onIncrement,
                              child: const Icon(Icons.add,
                                  size: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
