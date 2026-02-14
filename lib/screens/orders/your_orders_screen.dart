// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../data/dummy_products.dart';
// import '../../models/order_item.dart';
// import '../../models/product.dart';
// import '../../providers/cart_provider.dart';
// import '../../ui/common/app_colors.dart';
// import '../../ui/common/base_screen.dart';
// import '../../ui/widgets/home_search_bar.dart';
// import '../navigation/main_navigation.dart';
// import '../need_help/need_help_dialog.dart';
// import 'cancel_order_dialog.dart';
// import 'order_details_screen.dart';
//
// import 'order_time_filter.dart';
// import 'order_time_filter_sheet.dart';
// import 'orders_model.dart';
//
// class YourOrdersScreen extends StatefulWidget {
//   const YourOrdersScreen({super.key});
//
//   @override
//   State<YourOrdersScreen> createState() => _YourOrdersScreenState();
// }
//
// class _YourOrdersScreenState extends State<YourOrdersScreen> {
//   OrderTimeFilter _selectedFilter = OrderTimeFilter.lastWeek;
//
//   late final List<OrderModel> _orders;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _orders = [
//
//       /// 🛒 ACTIVE PRODUCT
//       OrderModel(
//         orderId: "ORD001",
//         address: "Gachibowli, Hyderabad",
//         orderDate: DateTime.now().subtract(const Duration(days: 2)),
//         status: OrderStatus.active,
//         items: [
//           OrderItem(
//             title: 'Low-Fat Buffalo Milk',
//             subtitle: 'Daily consumption',
//             price: '₹ 470/-',
//             image: popularProducts[0].image,
//             quantity: 1,
//           ),
//         ],
//       ),
//
//       /// 🛒 COMPLETED PRODUCT
//       OrderModel(
//         orderId: "ORD002",
//         address: "Indira Nagar, Hyderabad",
//         orderDate: DateTime.now().subtract(const Duration(days: 3)),
//         status: OrderStatus.completed,
//         items: [
//           OrderItem(
//             title: 'Pure Cow Ghee',
//             subtitle: 'Traditional & aromatic',
//             price: '₹ 999/-',
//             image: popularProducts[1].image,
//             quantity: 1,
//           ),
//         ],
//       ),
//
//       /// 🐄 RENT COW
//       OrderModel(
//         orderId: "ORD003",
//         address: "Kondapur, Hyderabad",
//         orderDate: DateTime.now().subtract(const Duration(days: 1)),
//         status: OrderStatus.active,
//         items: [
//           OrderItem(
//             title: 'Rent Cow',
//             subtitle: 'Gruhapravesham',
//             price: '₹ 570/-',
//             image: 'assets/images/cow.jpg',
//             quantity: 1,
//           ),
//         ],
//       ),
//     ];
//
//   }
//     List<OrderModel> get _filteredOrders {
//     final now = DateTime.now();
//
//     return _orders.where((order) {
//       switch (_selectedFilter) {
//         case OrderTimeFilter.lastWeek:
//           return order.orderDate.isAfter(
//             now.subtract(const Duration(days: 7)),
//           );
//         case OrderTimeFilter.pastThreeMonths:
//           return order.orderDate.isAfter(
//             DateTime(now.year, now.month - 3, now.day),
//           );
//         case OrderTimeFilter.thisYear:
//           return order.orderDate.year == now.year;
//         case OrderTimeFilter.lastYear:
//           return order.orderDate.year == now.year - 1;
//       }
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BaseScreen(
//
//       statusBarColor: AppColors.white,
//       statusBarIconBrightness: Brightness.dark,
//       child: Column(
//         children: [
//
//           /// 🔹 APP BAR
//           SafeArea(
//             bottom: false,
//             child: Container(
//               height: 56,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               decoration: const BoxDecoration(
//                 color: AppColors.white,
//                 border: Border(
//                   bottom: BorderSide(color: Color(0xFFE7E7E7)),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Icon(Icons.arrow_back, color: AppColors.black),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Your Orders',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           /// 🔍 SEARCH + FILTER
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 const Expanded(child: HomeSearchBar()),
//                 const SizedBox(width: 12),
//                 GestureDetector(
//                   onTap: () async {
//                     final result =
//                     await showModalBottomSheet<OrderTimeFilter>(
//                       context: context,
//                       backgroundColor: Colors.transparent,
//                       builder: (_) => OrderTimeFilterSheet(
//                         selected: _selectedFilter,
//                       ),
//                     );
//
//                     if (result != null) {
//                       setState(() => _selectedFilter = result);
//                     }
//                   },
//                   child: Container(
//                     height: 48,
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(24),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.shadow,
//                           blurRadius: 8,
//                         ),
//                       ],
//                     ),
//                     child: const Row(
//                       children: [
//                         Icon(Icons.filter_list, size: 18),
//                         SizedBox(width: 6),
//                         Text(
//                           'Filter',
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           /// 📦 ORDERS LIST
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: _filteredOrders.length,
//               itemBuilder: (_, index) {
//                 return _OrderCard(order: _filteredOrders[index]);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }
//
// class _OrderCard extends StatelessWidget {
//   final OrderModel order;
//
//   const _OrderCard({required this.order});
//
//   @override
//   Widget build(BuildContext context) {
//
//     final item = order.items.first; // 👈 get first product
//     final bool isRentCow = item.title == 'Rent Cow';
//     final bool isCancelled = order.status == OrderStatus.cancelled;
//     final bool isCompleted = order.status == OrderStatus.completed;
//
//
//
//
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF6F6F6),
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(color: const Color(0xFFE7E7E7)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//
//           /// ───────── MAIN CARD ─────────
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 /// IMAGE
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: item.image.startsWith('http')
//                       ? Image.network(
//                     item.image,
//                     width: 90,
//                     height: 90,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) => Container(
//                       width: 90,
//                       height: 90,
//                       color: Colors.grey.shade300,
//                       child: const Icon(Icons.image, color: Colors.grey),
//                     ),
//                   )
//                       : Image.asset(
//                     item.image,
//                     width: 90,
//                     height: 90,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//
//
//
//                 const SizedBox(width: 12),
//
//                 /// CONTENT
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       /// Title + Subtitle
//                       Text(item.title,
//                           style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xFF252525))),
//                       const SizedBox(height: 4),
//                       Text(item.subtitle,
//                           style: const TextStyle(
//                               fontSize: 10,
//                               color: Color(0xFF595959))),
//                       const SizedBox(height: 6),
//
//                       /// Price
//                       Text(item.price,
//                           style: const TextStyle(
//                               fontSize: 14,
//                               color: Color(0xFF252525))),
//                       const SizedBox(height: 10),
//
//                       /// Date + Button
//                       /// DATE (separate line)
//                       const Text(
//                         'Order Placed on 23 Dec, 7:46AM',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Color(0xFF252525),
//                         ),
//                       ),
//
//                       const SizedBox(height: 12),
//
//                       /// BUTTON ROW
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           _buildButton(context, isRentCow, isCancelled),
//                         ],
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           /// ───────── BOTTOM STRIP ─────────
//           /// ───────── DYNAMIC PRODUCT BOTTOM STRIP ─────────
//           if (!isRentCow)
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               decoration: const BoxDecoration(
//                 color: Color(0xFFEDEDEE),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(24),
//                   bottomRight: Radius.circular(24),
//                 ),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//
//                   /// 🔹 ACTIVE → Cancel Order (Text Primary Only)
//                   if (!isCancelled && order.status == OrderStatus.active)
//                     GestureDetector(
//                       onTap: () {
//                         showCancelOrderDialog(context, order);
//                       },
//                       child: const Text(
//                         "Cancel Order",
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: AppColors.primary, // ✅ Primary color text only
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//
//                   /// 🔹 COMPLETED → Need Help (Text Primary Only)
//                   if (!isCancelled && order.status == OrderStatus.completed)
//                     GestureDetector(
//                       onTap: () {
//                         showNeedHelpDialog(context, order);
//                       },
//                       child: const Text(
//                         "Need Help",
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: AppColors.primary, // ✅ Primary color text only
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//
//                   /// 🔹 CANCELLED
//                   if (isCancelled)
//                     const Text(
//                       "Order Cancelled",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.red,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//
//
//
//         ],
//       ),
//     );
//   }
//
//     /// ───────── BUTTON STYLES ─────────
//   Widget _buildButton(
//       BuildContext context,
//       bool isRentCow,
//       bool isCancelled,
//       ) {
//
//     final bool isCompleted = order.status == OrderStatus.completed;
//
//     final bool isActive = order.status == OrderStatus.active;
//
//     /// 🔹 Refund initiated button
//     if (isCancelled) {
//       return Container(
//         height: 38,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: const Color(0xFF049150)),
//         ),
//         alignment: Alignment.center,
//         child: const Text(
//           'Refund Initiated',
//           style: TextStyle(
//             fontSize: 14,
//             color: Color(0xFF049150),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       );
//     }
//
//     /// 🔹 Decide Button Text
//     String buttonText;
//
//     if (isRentCow) {
//       buttonText = "View Receipt";
//     } else if (isActive) {
//       buttonText = "Track";
//     } else {
//       buttonText = "Re-order";
//     }
//
//     return GestureDetector(
//       onTap: () {
//
//         /// 🐄 RENT COW
//         if (isRentCow) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => OrderDetailsScreen(order: order),
//             ),
//           );
//         }
//
//         /// 🛒 PRODUCT ACTIVE → Track
//         else if (isActive) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => OrderDetailsScreen(order: order),
//             ),
//           );
//         }
//
//         /// 🛒 PRODUCT COMPLETED → Re-order
//         else {
//           final cartProvider =
//           Provider.of<CartProvider>(context, listen: false);
//
//           final product = popularProducts.firstWhere(
//                 (p) => p.title == order.items.first.title,
//
//             orElse: () => popularProducts.first,
//           );
//
//           cartProvider.addToCart(product);
//
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => const MainNavigation(initialIndex: 3),
//             ),
//           );
//         }
//       },
//       child: Container(
//         height: 38,
//         padding: const EdgeInsets.symmetric(horizontal: 18),
//         decoration: BoxDecoration(
//           color: const Color(0xFF049150),
//           borderRadius: BorderRadius.circular(18),
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           buttonText,
//           style: const TextStyle(
//             fontSize: 14,
//             color: Colors.white,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/order_item.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/common/base_screen.dart';
import '../../ui/widgets/home_search_bar.dart';
import '../navigation/main_navigation.dart';
import '../need_help/need_help_dialog.dart';
import 'cancel_order_dialog.dart';
import 'order_details_screen.dart';
import 'order_time_filter.dart';
import 'order_time_filter_sheet.dart';
import '../../models/orders_model.dart';
import '../../utils/date_utils.dart'; // ✅ YOUR reusable date file

class YourOrdersScreen extends StatefulWidget {
  const YourOrdersScreen({super.key});

  @override
  State<YourOrdersScreen> createState() => _YourOrdersScreenState();
}

class _YourOrdersScreenState extends State<YourOrdersScreen> {
  OrderTimeFilter _selectedFilter = OrderTimeFilter.lastWeek;

  List<OrderModel> _filterOrders(List<OrderModel> orders) {
    final now = DateTime.now();

    return orders.where((order) {
      switch (_selectedFilter) {
        case OrderTimeFilter.lastWeek:
          return order.orderDate
              .isAfter(now.subtract(const Duration(days: 7)));

        case OrderTimeFilter.pastThreeMonths:
          return order.orderDate
              .isAfter(DateTime(now.year, now.month - 3, now.day));

        case OrderTimeFilter.thisYear:
          return order.orderDate.year == now.year;

        case OrderTimeFilter.lastYear:
          return order.orderDate.year == now.year - 1;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orders;
    final filteredOrders = _filterOrders(orders);

    return BaseScreen(
      statusBarColor: AppColors.white,
      statusBarIconBrightness: Brightness.dark,
      child: Column(
        children: [

          /// 🔹 APP BAR
          SafeArea(
            bottom: false,
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE7E7E7)),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: AppColors.black),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Your Orders',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🔍 SEARCH + FILTER
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Expanded(child: HomeSearchBar()),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () async {
                    final result =
                    await showModalBottomSheet<OrderTimeFilter>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (_) => OrderTimeFilterSheet(
                        selected: _selectedFilter,
                      ),
                    );

                    if (result != null) {
                      setState(() => _selectedFilter = result);
                    }
                  },
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.filter_list, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'Filter',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 📦 ORDERS LIST
          Expanded(
            child: filteredOrders.isEmpty
                ? const Center(
              child: Text(
                "No Orders Found",
                style: TextStyle(color: AppColors.grey),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredOrders.length,
              itemBuilder: (_, index) {
                return _OrderCard(order: filteredOrders[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderModel order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final item = order.items.first;
    final remainingCount = order.items.length - 1;

    final bool isRentCow = item.title == 'Rent Cow';
    final bool isCancelled = order.status == OrderStatus.cancelled;
    final bool isCompleted = order.status == OrderStatus.completed;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE7E7E7)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// MAIN CARD
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: item.image.startsWith('http')
                      ? Image.network(
                    item.image,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image,
                          color: Colors.grey),
                    ),
                  )
                      : Image.asset(
                    item.image,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 12),

                /// CONTENT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(item.title,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF252525))),
                      const SizedBox(height: 4),
                      Text(item.subtitle,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF595959))),
                      const SizedBox(height: 4),

                      if (remainingCount > 0)
                        Text(
                          "+$remainingCount more item(s)",
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.grey,
                          ),
                        ),

                      const SizedBox(height: 6),

                      Text(item.price,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF252525))),
                      const SizedBox(height: 10),

                      Text(
                        'Order Placed on  ${AppDateUtils.formatDate(order.orderDate)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF252525),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildButton(context, isRentCow, isCancelled),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// BOTTOM STRIP
          if (!isRentCow)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFEDEDEE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  if (!isCancelled &&
                      order.status == OrderStatus.active)
                    GestureDetector(
                      onTap: () {
                        showCancelOrderDialog(context, order);
                      },
                      child: const Text(
                        "Cancel Order",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  if (!isCancelled &&
                      order.status == OrderStatus.completed)
                    GestureDetector(
                      onTap: () {
                        showNeedHelpDialog(context, order);
                      },
                      child: const Text(
                        "Need Help",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  if (isCancelled)
                    const Text(
                      "Order Cancelled",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context,
      bool isRentCow,
      bool isCancelled,
      ) {

    final bool isActive = order.status == OrderStatus.active;

    if (isCancelled) {
      return Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF049150)),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Refund Initiated',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF049150),
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    String buttonText;

    if (isRentCow) {
      buttonText = "View Receipt";
    } else if (isActive) {
      buttonText = "Track";
    } else {
      buttonText = "Re-order";
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrderDetailsScreen(order: order),
          ),
        );
      },
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: const Color(0xFF049150),
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
