import 'package:flutter/material.dart';
 import 'package:provider/provider.dart';
import '../orders/order_status.dart';
import '../orders/order_placed_screen.dart';

import '../../providers/cart_provider.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/widgets/cart_item_card.dart';
import '../../ui/widgets/home_search_bar.dart';
import '../../ui/widgets/empty_cart_view.dart';
import '../home/sections/location_header.dart';
import '../navigation/main_navigation.dart';

import '../products/products_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items.keys.toList();

    final total = cart.totalAmount;
    const discount = 20.0;
    const delivery = 50.0;
    final payable = total - discount + delivery;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// 🔝 HEADER
          SafeArea(
            bottom: false,
            child: LocationHeader(
              title: 'Orders',
              subtitle: 'Indira Nagar, Gachibowli, Hyder...',
              showBack: true,
              showDropdown: false,
                onBack: () {
                  MainNavigation.navKey.currentState?.switchTab(0);
                },


            ),
          ),

          const SizedBox(height: 12),

          /// 🔍 SEARCH
          const HomeSearchBar(),

          const SizedBox(height: 16),

          /// 🛒 CART BODY
          Expanded(
            child: cart.items.isEmpty
                ? EmptyCartView(
              onBrowse: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductsScreen(
                      initialCategory: 'Products',
                      onBackToHome: () => Navigator.pop(context),
                    ),
                  ),
                );
              },
            )
                : ListView(
              children: [
                /// 🛍 CART ITEMS
                ...items.map((product) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: CartItemCard(
                      product: product,
                      quantity: cart.quantity(product),
                      onIncrement: () => cart.increase(product),
                      onDecrement: () => cart.decrease(product),
                    ),
                  );
                }),

                /// ➕ ADD MORE PRODUCTS
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductsScreen(
                          initialCategory: 'Products',
                          onBackToHome: () => Navigator.pop(context),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color(0xFFB2B4B8),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 12),
                        Text(
                          'Add more Products',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// 💰 BILL DETAILS
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(15),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF6F6F6),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Color(0xFFE9E9E9)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bill details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),

                      _billRow(
                        'Total Cart',
                        '₹${total.toStringAsFixed(0)}',
                      ),
                      _billRow(
                        'Discount',
                        '-₹20 (20%)',
                        green: true,
                      ),
                      _billRow('Delivery charge', '+₹50'),

                      const Divider(height: 24),

                      _billRow(
                        'To paid',
                        '₹${payable.toStringAsFixed(0)}',
                        bold: true,
                      ),
                    ],
                  ),
                ),

                /// ✅ PROCEED TO PAY
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OrderPlacedScreen(
                          status: OrderStatus.success,
                        ),
                      ),
                    );

                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Proceed to Pay',
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
        ],
      ),
    );
  }

  Widget _billRow(
      String label,
      String value, {
        bool green = false,
        bool bold = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              color: green ? AppColors.primary : Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              color: green ? AppColors.primary : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
