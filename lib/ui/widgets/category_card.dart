import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../../models/category_item.dart';

class CategoryCard extends StatelessWidget {
  final CategoryItem category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // ✅ FIX
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                category.image,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: Text(
                category.name,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
