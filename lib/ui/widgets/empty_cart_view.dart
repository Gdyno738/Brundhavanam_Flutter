import 'package:flutter/material.dart';
import '../../screens/navigation/main_navigation.dart';
import '../common/app_colors.dart';

class EmptyCartView extends StatelessWidget {
  final VoidCallback onBrowse;

  const EmptyCartView({
    super.key,
    required this.onBrowse,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🛒 ICON / IMAGE
            Icon(
              Icons.shopping_cart_outlined,
              size: 96,
              color: AppColors.grey,
            ),

            const SizedBox(height: 20),

            /// TITLE
            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),

            const SizedBox(height: 8),

            /// SUBTITLE
            const Text(
              'Looks like you haven’t added anything yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),

            const SizedBox(height: 28),

            /// CTA BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const MainNavigation(initialIndex: 2),
                    ),
                  );
                },


                child: const Text(
                  'Browse Products',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
