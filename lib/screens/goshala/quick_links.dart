import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import 'goshala_section.dart';

class QuickLinks extends StatelessWidget {
  final GoshalaSection selected;
  final ValueChanged<GoshalaSection> onChanged;

  const QuickLinks({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _item('Live', GoshalaSection.live),
          _item('History', GoshalaSection.history),
          _item('Donate', GoshalaSection.donate),
          _item('Gallery', GoshalaSection.gallery),
        ],
      ),
    );
  }

  Widget _item(String text, GoshalaSection value) {
    final bool isActive = selected == value;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isActive ? AppColors.primary : const Color(0xFFB7B1B1),
          ),
          boxShadow: isActive
              ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 10),
              blurRadius: 10,
            ),
          ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? AppColors.white : AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
