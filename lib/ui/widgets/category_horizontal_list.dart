import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class CategoryHorizontalList extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

   const CategoryHorizontalList({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Milk',
      'Ghee',
      'Curd',
      'Paneer',
      'Cheese',
      'Butter',
    ];

    return SizedBox(
      height: 105,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 18),
        itemBuilder: (_, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return GestureDetector(
            onTap: () => onCategorySelected(category),
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
                    image: const DecorationImage(
                      image: NetworkImage('https://placehold.co/64x64'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category,
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
}
