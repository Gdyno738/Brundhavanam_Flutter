import 'dart:convert';
import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../../data/dummy_categories.dart';
import '../../models/category_item.dart';

class CategoryHorizontalList extends StatelessWidget {
  final String selectedCategory;
  final Function(String)? onCategorySelected;
  final Function(String)? onCategoryTap;
  final bool enableNavigation;

  const CategoryHorizontalList({
    super.key,
    required this.selectedCategory,
    this.onCategorySelected,
    this.onCategoryTap,
    this.enableNavigation = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 18),
        itemBuilder: (_, index) {
          final CategoryItem category = categories[index];
          final bool isSelected = category.name == selectedCategory;

          return GestureDetector(
            onTap: () {
              if (enableNavigation && onCategoryTap != null) {
                onCategoryTap!(category.name);
              } else if (onCategorySelected != null) {
                onCategorySelected!(category.name);
              }
            },
            child: Column(
              children: [
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                    image: DecorationImage(
                      image: _buildImageProvider(category.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? AppColors.primary
                        : const Color(0xFF2C2C2C),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ✅ Handles BOTH network & base64 images safely
  ImageProvider _buildImageProvider(String image) {
    if (image.startsWith('data:image')) {
      final base64Str = image.split(',').last;
      return MemoryImage(base64Decode(base64Str));
    } else {
      return NetworkImage(image);
    }
  }
}
