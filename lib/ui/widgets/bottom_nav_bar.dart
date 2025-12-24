import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      color: AppColors.white,
      child: Column(
        children: [
          const SizedBox(height: 30),

          Row(
            children: [
              _NavItem(
                label: 'Home',
                isActive: true,
              ),
              _NavItem(
                label: 'Rent Cow',
              ),
              _NavItem(
                label: 'Products',
              ),
              _NavItem(
                label: 'Cart',
              ),
              _NavItem(
                label: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 🔹 Single nav item widget
class _NavItem extends StatelessWidget {
  final String label;
  final bool isActive;

  const _NavItem({
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            // 👉 Replace with Icon/Image later
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Inter',
              fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
              color: isActive
                  ? AppColors.primaryDark
                  : AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
