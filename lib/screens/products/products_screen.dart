import 'package:flutter/material.dart';
import '../../data/dummy_products.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/widgets/category_horizontal_list.dart';
import '../../ui/widgets/home_search_bar.dart';
import '../../ui/widgets/product_card.dart';
import '../category/category_products_screen.dart';
import '../home/sections/location_header.dart';

class ProductsScreen extends StatefulWidget {
  final String initialCategory;
  final VoidCallback onBackToHome;

  const ProductsScreen({
    super.key,
    required this.initialCategory,
    required this.onBackToHome,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with AutomaticKeepAliveClientMixin {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// 🔝 HEADER
          SafeArea(
            bottom: false,
            child: LocationHeader(
              title: 'Products',
              subtitle: '',
              showBack: true,
              showDropdown: false,
              onBack: widget.onBackToHome, // ✅ CORRECT FIX
            ),
          ),

          const SizedBox(height: 12),

          /// 🔍 SEARCH
          const HomeSearchBar(),

          const SizedBox(height: 12),

          /// 🧀 CATEGORY → OPENS NEW SCREEN
          CategoryHorizontalList(
            selectedCategory: selectedCategory,
            onCategorySelected: (category) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (_, __, ___) =>
                      CategoryProductsScreen(category: category),
                  transitionsBuilder: (_, animation, __, child) {
                    return SlideTransition(
                      position: Tween(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          /// 🛒 PRODUCTS GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: popularProducts.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (_, index) {
                return ProductCard(product: popularProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
