import 'package:flutter/material.dart';
import '../../screens/navigation/main_navigation.dart';
import '../common/app_colors.dart';

class FullWidthBanner extends StatelessWidget {
  const FullWidthBanner({super.key});

  void _goToBook(BuildContext context) {
    final navState = MainNavigation.navKey.currentState;

    if (navState != null && navState.mounted) {
      navState.switchTab(1);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 236,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/bannerImages/rectangle_banner.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: const Offset(-40, 40),
            child: GestureDetector(
              onTap: () => _goToBook(context), // ✅ FIX
              child: Container(
                width: 105,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
