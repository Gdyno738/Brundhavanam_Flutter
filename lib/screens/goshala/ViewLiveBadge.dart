import 'package:flutter/material.dart';

class ViewLiveBadge extends StatelessWidget {
  const ViewLiveBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(24), // pill shape
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 🔴 RED DOT
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFFF0B0B),
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 8),

          /// TEXT
          const Text(
            'View live',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(width: 6),

          /// ARROW
          const Icon(
            Icons.arrow_forward,
            size: 16,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
