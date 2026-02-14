import 'dart:async';
import 'package:flutter/material.dart';
import '../../screens/donate/donation_success_view_live_screen.dart';
import '../../screens/orders/order_preview_screen.dart';
import '../../models/orders_model.dart';
import '../../ui/common/app_colors.dart';

enum PaymentType {
  donation,
  order,
  rentCow,
}


class PaymentSuccessScreen extends StatefulWidget {
  final PaymentType type;
  final List<OrderModel>? orders; // 👈 add this

  const PaymentSuccessScreen({
    super.key,
    required this.type,
    this.orders,
  });

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}



class _PaymentSuccessScreenState extends State<PaymentSuccessScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward();

    /// ⏳ AUTO NAVIGATION
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      if (widget.type == PaymentType.donation) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const DonationSuccessViewLiveScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => OrderPreviewScreen(
              orders: widget.orders ?? [],
            ),
          ),
        );

      }
    });


  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get _title {
    switch (widget.type) {
      case PaymentType.donation:
        return "Payment Successful";
      case PaymentType.order:
        return "Order Placed Successfully";
      case PaymentType.rentCow:
        return "Booking Confirmed";
    }
  }

  String get _subtitle {
    switch (widget.type) {
      case PaymentType.donation:
        return "Thank you for supporting Goshala";
      case PaymentType.order:
        return "Your order has been placed successfully";
      case PaymentType.rentCow:
        return "Your cow booking has been confirmed";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// ✅ Animated Icon
              ScaleTransition(
                scale: _scaleAnim,
                child: const Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                  size: 90,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                _title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                _subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

