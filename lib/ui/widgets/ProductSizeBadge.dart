import 'package:flutter/material.dart';

class ProductSizeBadge extends StatelessWidget {
  final String size;

  const ProductSizeBadge({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: const BoxDecoration(
        color: Color(0xFFEEFFF6),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: Text(
        size,
        style: const TextStyle(
          color: Color(0xFF049150),
          fontSize: 10,
          fontWeight: FontWeight.w400,
          height: 1,
        ),
      ),
    );
  }
}
