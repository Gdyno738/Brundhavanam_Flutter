import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  Widget _navItem({
    required int index,
    required String icon,
    required String label,
  }) {
    final isActive = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Transform.translate(
        offset: const Offset(0, -6), // 👈 icon + text move together
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  icon,
                  width: 22,
                  height: 22,
                  color: isActive ? Colors.white : AppColors.grey,
                ),
              ),
            ),

            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isActive ? AppColors.primary : AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        /// MAIN NAV CONTAINER
        Container(
          height: 90,
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: const Border(
              top: BorderSide(
                color: Color(0xFF049150),
                width: 1.5,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(index: 0, icon: 'assets/icons/home.png', label: 'Home'),
              _navItem(index: 1,
                  icon: 'assets/icons/rent_cow.png',
                  label: 'Rent Cow'),
              _navItem(index: 2,
                  icon: 'assets/icons/products.png',
                  label: 'Products'),
              _navItem(index: 3, icon: 'assets/icons/cart.png', label: 'Cart'),
              _navItem(
                  index: 4, icon: 'assets/icons/profile.png', label: 'Profile'),
            ],
          ),
        ),

        /// LEFT GRADIENT BORDER
        /// LEFT GRADIENT BORDER
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.0, 0.5, 1.0],
                colors: [
                  Colors.white,          // bottom
                  Color(0xFF6FCF97),     // middle light green
                  Color(0xFF049150),     // top dark green
                ],
              ),
            ),
          ),
        ),

        /// RIGHT GRADIENT BORDER
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.0, 0.5, 1.0],
                colors: [
                  Colors.white,
                  Color(0xFF6FCF97),
                  Color(0xFF049150),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}