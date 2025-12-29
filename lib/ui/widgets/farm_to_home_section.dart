import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class FarmToHomeSection extends StatelessWidget {
  const FarmToHomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: const [
          /// TITLE
          SizedBox(
            width: double.infinity, // 🔑 IMPORTANT
            child: Text(
              'From Our Farm to Your Home',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ),

          SizedBox(height: 12),

          /// SUBTITLE (3 lines)
          SizedBox(
            width: double.infinity, // 🔑 IMPORTANT
            child: Text(
              'Pure care, honest practices,\n'
                  'and transparent service—everything\n'
                  'we stand for, in one glimpse.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.2,
                letterSpacing: 0.16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
