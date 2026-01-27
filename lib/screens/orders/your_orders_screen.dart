import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/widgets/home_search_bar.dart';
import '../navigation/main_navigation.dart';
import 'order_cancle_bottom_sheet.dart';
import 'order_details_screen.dart';

import 'order_time_filter.dart';
import 'order_time_filter_sheet.dart';
import 'orders_model.dart';

class YourOrdersScreen extends StatefulWidget {
  const YourOrdersScreen({super.key});

  @override
  State<YourOrdersScreen> createState() => _YourOrdersScreenState();
}

class _YourOrdersScreenState extends State<YourOrdersScreen> {
  OrderTimeFilter _selectedFilter = OrderTimeFilter.lastWeek;

  late final List<OrderModel> _orders;

  @override
  void initState() {
    super.initState();

    _orders = [
      OrderModel(
        title: 'Rent Cow',
        subtitle: 'Gruhapravesham',
        price: '₹ 570/-',
        address: 'Gachibowli, Hyderabad',
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
        status: OrderStatus.active,
        image: 'assets/images/cow.jpg', // ✅ cow image
      ),
      OrderModel(
        title: 'Low-Fat Buffalo Milk',
        subtitle: 'Daily consumption',
        price: '₹ 470/-',
        address: 'Indira Nagar, Hyderabad',
        orderDate: DateTime.now().subtract(const Duration(days: 10)),
        status: OrderStatus.completed,
        image: 'https://placehold.co/100x100', // ✅ product image
      ),
    ];
  }
    List<OrderModel> get _filteredOrders {
    final now = DateTime.now();

    return _orders.where((order) {
      switch (_selectedFilter) {
        case OrderTimeFilter.lastWeek:
          return order.orderDate.isAfter(
            now.subtract(const Duration(days: 7)),
          );
        case OrderTimeFilter.pastThreeMonths:
          return order.orderDate.isAfter(
            DateTime(now.year, now.month - 3, now.day),
          );
        case OrderTimeFilter.thisYear:
          return order.orderDate.year == now.year;
        case OrderTimeFilter.lastYear:
          return order.orderDate.year == now.year - 1;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        title: const Text(
          'Your Orders',
          style: TextStyle(color: AppColors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.filter_list,
                          size: 18,
                          color: AppColors.black,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Filter',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
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
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredOrders.length,
              itemBuilder: (_, index) {
                return _OrderCard(order: _filteredOrders[index]);
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
    final bool isRentCow = order.title == 'Rent Cow';
    final bool isCancelled = order.cancelled;
    final bool isCompleted = order.completed;

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

          /// ───────── MAIN CARD ─────────
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: isRentCow
                        ? const AssetImage('assets/images/cow.jpg')
                        : const NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpOKQJfpoon8pRe8VS5hmhTY_M8K5nNBC_lQ&s')
                    as ImageProvider,
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

                      /// Title + Subtitle
                      Text(order.title,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF252525))),
                      const SizedBox(height: 4),
                      Text(order.subtitle,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF595959))),
                      const SizedBox(height: 6),

                      /// Price
                      Text(order.price,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF252525))),
                      const SizedBox(height: 10),

                      /// Date + Button
                      /// DATE (separate line)
                      const Text(
                        'Order Placed on 23 Dec, 7:46AM',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF252525),
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// BUTTON ROW
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

          /// ───────── BOTTOM STRIP ─────────
          if (isRentCow)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: const BoxDecoration(
                color: Color(0xFFEDEDEE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [

                  if (!isCancelled && !isCompleted) ...[
                    const Text(
                      'Do you want to cancel the booking ?',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF049150),
                      ),
                    ),
                    const SizedBox(height: 2),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (_) => CancelOrderBottomSheet(order: order),
                        );
                      },
                      child: const Text(
                        'Cancel Order',
                        style: TextStyle(
                          fontSize: 9,
                          color: Color(0xFF049150),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],

                  if (isCancelled)
                    const Text(
                      'Order Cancelled',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.red,
                      ),
                    ),

                  if (isCompleted)
                    const Text(
                      'Completed',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.green,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// ───────── BUTTON STYLES ─────────
  Widget _buildButton(BuildContext context, bool isRentCow, bool isCancelled) {

    /// Refund initiated button
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

    /// View receipt / reorder
    return GestureDetector(
      onTap: () {
        if (isRentCow) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OrderDetailsScreen(order: order),
            ),
          );
        }
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
          isRentCow ? 'View Receipt' : 'Re-order',
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
