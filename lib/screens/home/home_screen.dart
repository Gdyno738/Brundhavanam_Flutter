import 'package:brundhavanam_app/screens/category/category_products_screen.dart';
import 'package:flutter/material.dart';

import '../../data/dummy_products.dart';
import '../../data/dummy_reviews.dart';
import '../../ui/common/app_colors.dart';
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
import '../products/products_screen.dart';
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
            child: const LocationHeader(
              title: 'DLF Cyber City',
              subtitle: 'Indira Nagar, Gachibowli, Hyder...',
              showBack: false,
            ),


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
                      debugPrint('View all dairy products');
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
                      debugPrint('View all popular products');
                    },
                  ),

                  const SizedBox(height: 20),

                  /// 🛒 Popular product cards
                  SizedBox(
                    height: 330,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: popularProducts.length,
                      separatorBuilder: (_,__) =>
                      const SizedBox(width: 20),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: popularProducts[index],
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

                  const BecomePartnerCard(),

                  const SizedBox(height: 20),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'What our clients say',
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
