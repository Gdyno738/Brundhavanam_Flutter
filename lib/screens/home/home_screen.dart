import 'package:brundhavanam_app/screens/category/category_products_screen.dart';
import 'package:flutter/material.dart';

import '../../data/dummy_products.dart';
import '../../data/dummy_reviews.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/common/base_screen.dart';
import '../../ui/widgets/banner_carousel.dart';
import '../../ui/widgets/become_partner_card.dart';
import '../../ui/widgets/category_horizontal_list.dart';
import '../../ui/widgets/contact_support_section.dart';
import '../../ui/widgets/farm_video_banner.dart';
import '../../ui/widgets/filter_horizontal_list.dart';
import '../../ui/widgets/full_width_banner.dart';
import '../../ui/widgets/home_search_bar.dart';
import '../../ui/widgets/product_card.dart';
import '../../ui/widgets/reviews_horizontal_list.dart';
import '../../ui/widgets/section_header.dart';
import '../../ui/widgets/farm_to_home_section.dart';
import '../../ui/widgets/why_trust_us_section.dart';

import '../category/category_grid_screen.dart';
import '../navigation/main_navigation.dart';

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
    return BaseScreen(
      child: Column(
        children: [
          LocationHeader(
            title: 'DLF',
            subtitle: 'Indira Nagar, Gachibowli',
            showBack: false,
            showDropdown: true,
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

                  /// 🥛 Section title
                  SectionHeader(
                    title: 'Dairy Products',
                    onViewAll: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CategoryGridScreen(),
                        ),
                      );
                    },

                  ),




                  /// 🧀 Category icons
                  CategoryHorizontalList(
                    selectedCategory: selectedCategory,
                    onCategorySelected: (category) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryProductsScreen(category: category)
                        ),
                      );
                    },
                  ),


                  const SizedBox(height: 20),

                  /// 🎯 Banner carousel
                  const BannerCarousel(),

                  const SizedBox(height: 20),

                  /// 🔘 Filters
                  const FilterHorizontalList(),

                  const SizedBox(height: 20),

                  /// ⭐ MOST POPULAR PRODUCTS
                  SectionHeader(
                    title: 'Most Popular Products',
                    onViewAll: () {
                      MainNavigation.navKey.currentState?.switchTab(2);
                    },
                  ),


                  const SizedBox(height: 20),

                  /// 🛒 Popular product cards
                  SizedBox(
                    height: 317, // ✅ enough for full ProductCard
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: popularProducts.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 20),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 185, // ✅ FIXED CARD WIDTH
                          child: ProductCard(
                            product: popularProducts[index],
                          ),
                        );
                      },
                    ),
                  ),


                  const SizedBox(height: 20),

                  /// 🟩 FULL WIDTH PROMO BANNER
                  const FullWidthBanner(),

                  const SizedBox(height: 20),

                  /// 🌱 FARM TO HOME TEXT
                  const FarmToHomeSection(),



                  const SizedBox(height: 20),

                  FarmVideoBanner(
                    videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                  ),

                  const SizedBox(height: 20),

                  const WhyTrustUsSection(),

                  const SizedBox(height: 20),

                  ContactSupportSection(),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Become Partner',
                      style: const TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  BecomePartnerCard(
                    onDonateTap: () {
                      MainNavigation.navKey.currentState?.switchTab(4); // 👈 Donate tab
                    },
                  ),


                  const SizedBox(height: 20),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'What our customers say',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ReviewsHorizontalList(reviews: dummyReviews),

                  const SizedBox(height: 20),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
