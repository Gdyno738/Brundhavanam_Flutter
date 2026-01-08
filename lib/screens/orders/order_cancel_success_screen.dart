import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';

class OrderCancelSuccessScreen extends StatelessWidget {
  const OrderCancelSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      /// 🔝 APP BAR
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      /// 📄 CONTENT
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ❌ STATUS
            const Text(
              'Order Cancelled Successfully',
              style: TextStyle(
                color: Colors.red, // ✅ error color
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 16),

            /// 🧾 ORDER SUMMARY
            _orderSummaryCard(),

            const SizedBox(height: 20),

            /// 💰 REFUND DETAILS
            _refundDetails(),

            const SizedBox(height: 20),

            /// ⏳ REFUND STATUS
            _refundTimeline(),
          ],
        ),
      ),
    );
  }

  /// 🧾 ORDER CARD
  Widget _orderSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.grey.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://placehold.co/124x124',
              width: 124,
              height: 124,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          /// DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Rent Cow',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Gruhapravesham',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '₹ 570/-',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Delivered on 24 Dec 2025',
                  style: TextStyle(fontSize: 12, color: AppColors.black),
                ),
                Text(
                  'Gachibowli, Hyderabad',
                  style: TextStyle(fontSize: 12, color: AppColors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 💰 REFUND BREAKUP
  Widget _refundDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.grey.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: const [
          _PriceRow('Product Price', '₹470/-'),
          _PriceRow('Delivery Charges', '₹100/-'),
          _PriceRowBold('Total Amount', '₹570/-'),
          _PriceRowRed('Remark', '-₹200/-'),
          Divider(color: AppColors.grey),
          _PriceRowBold('Refundable Amount', '₹370/-'),
        ],
      ),
    );
  }

  /// ⏳ REFUND TIMELINE
  Widget _refundTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _timelineItem(
          color: AppColors.primary,
          title: 'Refund Initiated',
          date: '25 Dec 2025',
        ),
        const SizedBox(height: 12),
        _timelineItem(
          color: AppColors.grey,
          title: 'Refund Completed',
          date: '25 Dec 2025',
          inactive: true,
        ),
      ],
    );
  }

  Widget _timelineItem({
    required Color color,
    required String title,
    required String date,
    bool inactive = false,
  }) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: inactive ? AppColors.grey : AppColors.black,
              ),
            ),
            Text(
              date,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// 🔹 PRICE ROW
class _PriceRow extends StatelessWidget {
  final String label;
  final String value;

  const _PriceRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.black)),
          Text(value, style: const TextStyle(color: AppColors.black)),
        ],
      ),
    );
  }
}

class _PriceRowBold extends _PriceRow {
  const _PriceRowBold(super.label, super.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceRowRed extends _PriceRow {
  const _PriceRowRed(super.label, super.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.black)),
          Text(
            value,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
