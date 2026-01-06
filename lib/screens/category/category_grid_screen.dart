import 'package:flutter/material.dart';
import '../../data/dummy_categories.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/widgets/category_card.dart';
import '../home/sections/location_header.dart';
import 'category_products_screen.dart';

class CategoryGridScreen extends StatelessWidget {
  const CategoryGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// HEADER
          SafeArea(
            bottom: false,
            child: LocationHeader(
              title: 'Categories',
              subtitle: '',
              showBack: true,
              showDropdown: false,
              onBack: () => Navigator.pop(context),
            ),
          ),

          const SizedBox(height: 16),

          /// CATEGORY GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categories.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];

                return CategoryCard(
                  category: category,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryProductsScreen(
                          category: category.name,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
