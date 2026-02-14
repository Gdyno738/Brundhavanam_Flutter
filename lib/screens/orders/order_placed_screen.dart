import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/widgets/cart_item_card.dart';
import '../navigation/main_navigation.dart';
import '../../models/orders_model.dart';
import 'order_tracking_screen.dart';

class OrderPlacedScreen extends StatelessWidget {
  final OrderStatus status;
  final OrderModel order;

  const OrderPlacedScreen({
    super.key,
    required this.status,
    required this.order,
  });

  void _goToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const MainNavigation(
          initialIndex: 0,
        ),
      ),
          (route) => false,
    );
  }


  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items.keys.toList();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _goToHome(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.black),
            onPressed: () => _goToHome(context),
          ),
          title: const Text(
            'Order Placed',
            style: TextStyle(color: AppColors.black),
          ),
        ),

        body: Column(
          children: [
            const SizedBox(height: 16),

            /// ✅ SUCCESS ICON
            Icon(
              status == OrderStatus.completed
                  ? Icons.check_circle
                  : Icons.error,
              size: 80,
              color: status == OrderStatus.completed
                  ? AppColors.primary
                  : Colors.red,
            ),

            const SizedBox(height: 12),

            Text(
              status == OrderStatus.completed
                  ? 'Your order is placed successfully'
                  : 'Payment failed',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),


            const SizedBox(height: 24),

            /// 🛍 ORDERED PRODUCTS
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Ordered Items',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ...items.map((product) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CartItemCard(
                        product: product,
                        quantity: cart.quantity(product),
                        onIncrement: () {},
                        onDecrement: () {},
                      ),
                    );
                  }),
                ],
              ),
            ),

            /// 🚚 TRACK ORDER BUTTON
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderTrackingScreen(order: order),
                      ),
                    );

                  },
                  child: const Text(
                    'Track Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
