import 'package:brundhavanam_app/ui/common/base_screen.dart';
import 'package:flutter/material.dart';
import '../../data/dummy_products.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/widgets/category_horizontal_list.dart';
import '../../ui/widgets/home_search_bar.dart';
import '../../ui/widgets/product_card.dart';
// import '../category/category_products_screen.dart';
import '../home/sections/location_header.dart';

class ProductsScreen extends StatefulWidget {
  final String initialCategory;
  final VoidCallback? onBackToHome;

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

  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = 'ALL'; // 👈 start with category grid
  }

  @override
  bool get wantKeepAlive => true;

  bool get showCategoryGrid => selectedCategory == null;


  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BaseScreen(
      child: Column(
        children: [
        LocationHeader(
              title: 'Products',
              subtitle: '',
              showBack: true,
              showDropdown: false,
              onBack: widget.onBackToHome ?? () => Navigator.pop(context),
            ),


          const SizedBox(height: 12),
          const HomeSearchBar(),
          const SizedBox(height: 12),

          CategoryHorizontalList(
            selectedCategory: selectedCategory ?? '',
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
          ),

          const SizedBox(height: 16),

          Expanded(
            child: showCategoryGrid
                ? _buildCategoryGrid()
                : _buildProductsGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    final categories = ['Milk', 'Ghee', 'Curd', 'Paneer', 'Cheese', 'Butter'];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.60,
      ),
      itemBuilder: (_, index) {
        final category = categories[index];

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedCategory = category;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductsGrid() {
    final products = selectedCategory == null || selectedCategory == 'ALL'
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
        childAspectRatio: 0.65,
      ),
      itemBuilder: (_, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

