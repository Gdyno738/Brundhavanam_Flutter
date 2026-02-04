import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          // ✅ NO BACKGROUND COLOR
          color: Colors.transparent,

          // ✅ BORDER CHANGES ON SELECTION
          border: Border.all(
            color: isSelected ? const Color(0xFF049150) : Colors.grey,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            // ✅ TEXT COLOR CHANGES ON SELECTION
            color: isSelected ? const Color(0xFF049150) : Colors.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
