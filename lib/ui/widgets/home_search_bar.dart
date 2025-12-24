import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback? onMicTap;
  final VoidCallback? onSearchTap;

  const HomeSearchBar({
    super.key,
    this.onMicTap,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFBABABA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x5B000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          /// 🔍 LEFT SEARCH ICON
          GestureDetector(
            onTap: onSearchTap,
            child: const Icon(
              Icons.search,
              size: 22,
              color: Color(0xFF7B7777),
            ),
          ),

          const SizedBox(width: 12),

          /// SEARCH TEXT
          const Expanded(
            child: Text(
              'Search',
              style: TextStyle(
                color: Color(0xFF7B7777),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          /// 🎤 RIGHT MIC ICON (CLICKABLE)
          GestureDetector(
            onTap: onMicTap,
            child: const Icon(
              Icons.mic,
              size: 22,
              color: Color(0xFF7B7777),
            ),
          ),
        ],
      ),
    );
  }
}
