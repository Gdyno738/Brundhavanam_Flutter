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
    final bool canCancel = !order.completed; // testing mode

    final bool isRentCow = order.title == 'Rent Cow';
    final String buttonText = isRentCow ? 'View Receipt' : 'Reorder';

    final String imageUrl = order.title == 'Rent Cow'
        ? 'assets/images/cow.jpg'
        : 'https://placehold.co/100x100';


    String statusText;
    Color statusColor;

    if (order.cancelled) {
      statusText = order.refundStatus == RefundStatus.initiated
          ? 'Refund Initiated'
          : 'Order Cancelled';
      statusColor = Colors.red;
    } else if (order.completed) {
      statusText = 'Completed';
      statusColor = AppColors.black;
    } else {
      statusText = 'On the way';
      statusColor = AppColors.primary;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          /// 🔹 MAIN CARD
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🖼 IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image(
                    image: order.title == 'Rent Cow'
                        ? const AssetImage('assets/images/cow.jpg')
                        : const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpOKQJfpoon8pRe8VS5hmhTY_M8K5nNBC_lQ&s')
                    as ImageProvider,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 12),

                /// 📄 CONTENT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.title,
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
                            statusText,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          /// ACTION BUTTON (unchanged)
                          GestureDetector(
                            onTap: () {
                              if (isRentCow)
                              { Navigator.push( context, MaterialPageRoute( builder: (_) => OrderDetailsScreen(order: order),
                              ),
                              );
                              }
                              else {
                                final product = Product( id: 'milk_001',
                                  image: 'https://placehold.co/150x150',
                                  title: order.title,
                                  description: order.subtitle,
                                  size: 'Default',
                                  price: double.parse( order.price .replaceAll(RegExp(r'[^\d.]'), ''),
                                  ),
                                  originalPrice: double.parse( order.price .replaceAll(RegExp(r'[^\d.]'), ''),
                                  ),
                                  category: 'Reorder', rating: 4.5, );
                                context .read<CartProvider>() .addToCart(product);
                                final state = MainNavigation.navKey.currentState;
                                if (state is MainNavigationState) { state.switchTab(3);
                                }
                                ScaffoldMessenger.of(context).showSnackBar( const SnackBar( content: Text('Product added to cart'),
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
                                buttonText,
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
                ),
              ],
            ),
          ),


          /// 🔻 CANCEL STRIP (FOR TESTING)
          if (canCancel)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              decoration: const BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => CancelOrderBottomSheet(order: order),

                  );
                },
                child: const Text(
                  'Do you want to cancel the booking ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
