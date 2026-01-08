import 'dart:async';
import 'package:flutter/material.dart';
import '../../screens/donate/donation_success_view_live_screen.dart';
import '../../ui/common/app_colors.dart';


class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

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

    /// ✅ SUCCESS ICON ANIMATION
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward();

    /// ⏳ AUTO NAVIGATION AFTER 2 SECONDS
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DonationSuccessViewLiveScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              /// ✅ ANIMATED SUCCESS ICON
              ScaleTransition(
                scale: _scaleAnim,
                child: const Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                  size: 90,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Payment Successful',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Thank you for supporting Goshala',
                style: TextStyle(
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
