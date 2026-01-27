import 'package:flutter/material.dart';

class ViewLiveBadge extends StatelessWidget {
  const ViewLiveBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // ⬆ bigger
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(32), // ⬆ more rounded pill
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 🔴 RED DOT
          Container(
            width: 12, // ⬆ bigger
            height: 12,
            decoration: const BoxDecoration(
              color: Color(0xFFFF0B0B),
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 10),

          /// TEXT
          const Text(
            'View live',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18, // ⬆ bigger
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(width: 10),

          /// ARROW
          const Icon(
            Icons.arrow_forward,
            size: 20, // ⬆ bigger
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
