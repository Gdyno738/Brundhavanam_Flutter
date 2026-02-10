import 'package:brundhavanam_app/ui/common/base_screen.dart';
import 'package:flutter/material.dart';
import '../../data/dummy_products.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/widgets/category_horizontal_list.dart';
import '../../ui/widgets/home_search_bar.dart';
import '../../ui/widgets/product_card.dart';
import '../home/sections/location_header.dart';
import '../navigation/main_navigation.dart';

class ProductsScreen extends StatefulWidget {
  final String? initialCategory;

  const ProductsScreen({
    super.key,
    this.initialCategory,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory; // null = ALL
  }

  // ✅ ONLY ADDED FUNCTIONALITY
  @override
  void didUpdateWidget(covariant ProductsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialCategory != widget.initialCategory) {
      setState(() {
        selectedCategory = widget.initialCategory;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(

      child: Column(
        children: [
          /// 🔝 HEADER
          LocationHeader(
            title: 'Products',
            subtitle: '',
            showBack: true,
            showDropdown: false,
            onBack: () => _goHome(context),


          ),

          const SizedBox(height: 12),
          const HomeSearchBar(),
          const SizedBox(height: 12),

          /// 🏷 CATEGORY LIST
          CategoryHorizontalList(
            selectedCategory: selectedCategory ?? 'ALL',
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category == 'ALL' ? null : category;
              });
            },
          ),

          const SizedBox(height: 16),

          /// 🧺 PRODUCTS GRID
          Expanded(child: _buildProductsGrid()),
        ],
      ),
    );
  }

  void _goHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const MainNavigation(initialIndex: 0),
      ),
    );
  }


  Widget _buildProductsGrid() {
    final products = selectedCategory == null
        ? popularProducts
        : popularProducts
        .where((p) => p.category == selectedCategory)
        .toList();

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.55,
      ),
      itemBuilder: (_, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
