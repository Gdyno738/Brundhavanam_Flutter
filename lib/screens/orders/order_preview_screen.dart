import 'package:brundhavanam_app/screens/orders/order_tracking_screen.dart';
import 'package:brundhavanam_app/ui/common/base_screen.dart';
import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import '../../models/orders_model.dart';
import 'order_details_screen.dart';

class OrderPreviewScreen extends StatelessWidget {
  final List<OrderModel> orders;

  const OrderPreviewScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      statusBarColor: AppColors.white,
      statusBarIconBrightness: Brightness.dark,
      child: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (_, index) {
                return _OrderPreviewCard(order: orders[index]);
              },
            ),
          ),
          //_buildPaymentDetails(),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6,
          )
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: AppColors.black),
          ),
          const SizedBox(width: 12),
          const Text(
            "Your Orders",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

//   Widget _buildPaymentDetails() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: const BoxDecoration(
//         color: AppColors.white,
//         border: Border(
//           top: BorderSide(color: AppColors.lightGrey),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: const [
//           Text(
//             "Payment Details",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               color: AppColors.black,
//             ),
//           ),
//           Text(
//             "₹2350",
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: AppColors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
}

class _OrderPreviewCard extends StatefulWidget {
  final OrderModel order;

  const _OrderPreviewCard({required this.order});

  @override
  State<_OrderPreviewCard> createState() => _OrderPreviewCardState();
}



class _OrderPreviewCardState extends State<_OrderPreviewCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    final bool isCowOrder =
        order.items.length == 1 &&
            order.items.first.subtitle == "Cow Booking";


    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 ORDER ITEMS (MULTIPLE)
          ...order.items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: item.image.startsWith('http')
                        ? Image.network(
                      item.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      item.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.subtitle,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${item.price} x${item.quantity}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 12),

          /// 🔹 DATE + TRACK BUTTON
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Placed on ${order.orderDate.day} "
                        "${_month(order.orderDate.month)}, "
                        "${order.orderDate.hour}:${order.orderDate.minute}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Estimation of delivery: 22 Dec",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          OrderTrackingScreen(order: order),
                    ),
                  );
                },
                child: Container(
                  height: 38,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Track",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],


    ),
            const SizedBox(height: 16),
            /// 🔹 PAYMENT DETAILS (Expandable)
            GestureDetector(
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.lightGrey),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Payment Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "₹${order.billing.totalAmount.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          _expanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 20,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

    AnimatedCrossFade(
    duration: const Duration(milliseconds: 300),
    crossFadeState: _expanded
    ? CrossFadeState.showSecond
        : CrossFadeState.showFirst,
    firstChild: const SizedBox.shrink(),
    secondChild: Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Column(
    children: [

                  /// 🔹 COW ORDER BILLING
                  if (isCowOrder) ...[
                    _billRow("Cow Cost", order.billing.subTotal),
                    const SizedBox(height: 8),
                    _billRow("Delivery Charges", order.billing.deliveryCharge),
                    const Divider(),
                    _billRow(
                      "Total",
                      order.billing.totalAmount,
                      bold: true,
                    ),
                  ]

                  /// 🔹 PRODUCT ORDER BILLING
                  else ...[
                    ...order.items.map((item) {
                      final numericPrice = double.tryParse(
                        item.price.replaceAll(RegExp(r'[^\d.]'), ''),
                      ) ?? 0;

                      final total = numericPrice * item.quantity;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: _billRow(
                          "${item.title} x${item.quantity}",
                          total,
                        ),
                      );
                    }),

                    const Divider(),

                    _billRow("Subtotal", order.billing.subTotal),
                    const SizedBox(height: 6),

                    _billRow(
                      "Discount",
                      order.billing.discount,
                      isGreen: true,
                    ),

                    const SizedBox(height: 6),

                    _billRow("Delivery", order.billing.deliveryCharge),

                    const Divider(),

                    _billRow(
                      "Total",
                      order.billing.totalAmount,
                      bold: true,
                    ),
                  ],
                ],
              ),
            ),


    ),

        ],
      ),
    );
  }

  String _month(int month) {
    const months = [
      "Jan","Feb","Mar","Apr","May","Jun",
      "Jul","Aug","Sep","Oct","Nov","Dec"
    ];
    return months[month - 1];
  }

  Widget _billRow(
      String label,
      double value, {
        bool bold = false,
        bool isGreen = false,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          "₹${value.toStringAsFixed(0)}",
          style: TextStyle(
            fontSize: 13,
            fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
            color: isGreen ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }

}

