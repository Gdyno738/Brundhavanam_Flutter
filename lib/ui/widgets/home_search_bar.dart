import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback? onMicTap;
  final ValueChanged<String>? onSearchChanged;
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const HomeSearchBar({
    super.key,
    this.onMicTap,
    this.onSearchChanged,
    this.margin,
    this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.lightGrey),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            size: 22,
            color: AppColors.grey,
          ),
          const SizedBox(width: 12),

          /// 🔤 TEXT FIELD (FOCUS WORKS)
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: false,
              onChanged: onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                isDense: true,
              ),
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
          ),

          InkWell(
            onTap: onMicTap,
            borderRadius: BorderRadius.circular(20),
            child: const Icon(
              Icons.mic,
              size: 22,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
