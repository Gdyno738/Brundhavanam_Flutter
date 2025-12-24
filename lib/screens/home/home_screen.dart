import 'package:flutter/material.dart';

import '../../data/dummy_products.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/widgets/banner_carousel.dart';
import '../../ui/widgets/bottom_nav_bar.dart';
import '../../ui/widgets/category_horizontal_list.dart';
import '../../ui/widgets/filter_horizontal_list.dart';
import '../../ui/widgets/home_search_bar.dart';
import '../../ui/widgets/product_card.dart';
import '../../ui/widgets/section_header.dart';
import 'sections/location_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Milk';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// ✅ SAFE FOR NOTCH / STATUS BAR
          SafeArea(
            bottom: false,
            child: const LocationHeader(),
          ),

          /// ✅ REST OF SCREEN
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  /// 🔍 Search bar
                  const HomeSearchBar(),

                  const SizedBox(height: 12),
                  SectionHeader(
                    title: 'Dairy Products',
                    onViewAll: () {
                      debugPrint('View all dairy products');
                    },
                  ),

                  /// 🧀 Category icons (Milk, Ghee, etc.)
                  CategoryHorizontalList(
                    selectedCategory: selectedCategory,
                    onCategorySelected: (category) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  /// 🎯 Banner carousel
                  const BannerCarousel(),

                  const SizedBox(height: 20),

                  /// 🔘 Filters
                  const FilterHorizontalList(),

                  const SizedBox(height: 24),

                /// ⭐ MOST POPULAR PRODUCTS
                SectionHeader(
                    title: 'Most Popular Products',
                    onViewAll: () {
                      debugPrint('View all popular products');
                    },
                ),

                  /// 🥛 Section header


                  /// 🛒 Product cards
                  // SizedBox(
                  //   height: 330,
                  //   child: ListView.separated(
                  //     scrollDirection: Axis.horizontal,
                  //     padding: const EdgeInsets.symmetric(horizontal: 16),
                  //     itemCount: products.length,
                  //     separatorBuilder: (_, __) =>
                  //     const SizedBox(width: 20),
                  //     itemBuilder: (_, index) {
                  //       return ProductCard(
                  //         product: products[index],
                  //       );
                  //     },
                  //   ),
                  // ),

                  const SizedBox(height: 40),

                  SizedBox(
                    height: 330,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: popularProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 20),

                      // 👇 index is defined HERE
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: popularProducts[index], // ✅ VALID
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
