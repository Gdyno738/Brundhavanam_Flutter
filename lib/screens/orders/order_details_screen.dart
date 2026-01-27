import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import 'orders_model.dart';
import 'order_total_bill_screen.dart';


class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      /// APP BAR
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Your Orders',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ORDER DETAILS TITLE
            const Text(
              'Order Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),

            const SizedBox(height: 16),

            _infoRow('Order Placed', _formatDate(order.orderDate)),
            _infoRow('Order Number', _generateOrderNumber(order.orderDate)),

            const SizedBox(height: 16),

            /// DOWNLOAD RECEIPT BUTTON
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Receipt download coming soon')),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Download Receipt',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                    Icon(Icons.download, size: 18),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// PRODUCT CARD
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  /// IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'assets/images/cow360_1.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// DETAILS
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          order.subtitle,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.grey,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          order.price,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          order.completed
                              ? 'Delivered on ${_formatDate(order.orderDate)}'
                              : 'On the way',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.grey,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          order.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () => _showTotalBillSheet(context),
                    child: const Icon(Icons.chevron_right),
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ORDER INFO ROW
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: AppColors.black),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, color: AppColors.black),
          ),
        ],
      ),
    );
  }

  /// DATE FORMATTER
  static String _formatDate(DateTime date) {
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  /// ORDER NUMBER GENERATOR
  static String _generateOrderNumber(DateTime date) {
    return '12547GH211225'; // matches your screenshot style
  }

  void _showTotalBillSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Total bill',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 20),

              _billRow('Cow', '₹470/-'),
              const SizedBox(height: 10),
              _billRow('Delivery Charges', '₹100/-'),

              const Divider(height: 30),

              _billRow('Total', '₹570/-', bold: true),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _billRow(String left, String right, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: TextStyle(
            fontSize: 14,
            fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          right,
          style: TextStyle(
            fontSize: 14,
            fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }

}
