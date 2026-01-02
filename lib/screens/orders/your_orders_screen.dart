import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/widgets/home_search_bar.dart';
import '../navigation/main_navigation.dart';
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
        buttonText: 'View Receipt',
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
        address: 'Gachibowli, Hyderabad',
        completed: true,
      ),
      OrderModel(
        title: 'Low-Fat Buffalo Milk',
        subtitle: 'Daily consumption',
        price: '₹ 470/-',
        buttonText: 'Reorder',
        orderDate: DateTime.now().subtract(const Duration(days: 10)),
        address: 'Indira Nagar, Hyderabad',
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
          /// 🔍 SEARCH + FILTER (SAME UI STYLE)
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
                    child: const Center(
                      child: Text(
                        'Filter',
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            order.title,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            order.subtitle,
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            order.price,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.completed ? 'Completed' : 'On the way',
                style: TextStyle(
                  color:
                  order.completed ? AppColors.black : AppColors.primary,
                  fontSize: 12,
                ),
              ),

              /// 👉 ACTION BUTTON (UNCHANGED UI)
              GestureDetector(
                onTap: () {
                  if (order.buttonText == 'View Receipt') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            OrderDetailsScreen(order: order),
                      ),
                    );
                  }

                  if (order.buttonText == 'Reorder') {
                    final product = Product(
                      image: 'https://placehold.co/150x150',
                      title: order.title,
                      description: order.subtitle,
                      size: 'Default',
                      price: double.parse(
                        order.price.replaceAll(RegExp(r'[^\d.]'), ''),
                      ),
                      originalPrice: double.parse(
                        order.price.replaceAll(RegExp(r'[^\d.]'), ''),
                      ),
                      category: 'Reorder',
                      rating: 4.5,
                    );

                    context.read<CartProvider>().addToCart(product);

                    final state = MainNavigation.navKey.currentState;
                    if (state is MainNavigationState) {
                      state.switchTab(3);
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product added to cart'),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    order.buttonText,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
