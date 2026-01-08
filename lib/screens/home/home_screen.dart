
import 'package:brundhavanam_app/screens/home/sections/location_picker_screen.dart';
import 'package:flutter/material.dart';


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
import '../../ui/widgets/most_popular_products_section.dart';

import '../../ui/widgets/reviews_horizontal_list.dart';
import '../../ui/widgets/section_header.dart';
import '../../ui/widgets/farm_to_home_section.dart';
import '../../ui/widgets/why_trust_us_section.dart';

import '../category/category_grid_screen.dart';
import '../donate/donate_screen.dart';



import '../popularproducts/popular_products_screen.dart';
import 'sections/location_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;


  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          LocationHeader(
            title: 'DLF Cyber City',
            subtitle: 'Indira Nagar, Gachibowli',
            showDropdown: true,
            showLocationIcon: true,
            onLocationTap: () async {
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const LocationPickerScreen(),
              );
            },
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
                    selectedCategory: selectedCategory ?? 'ALL',
                    onCategorySelected: (category) {
                      setState(() {
                        selectedCategory = category == 'ALL' ? null : category;
                      });
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
                  MostPopularProductsSection(
                    onViewAll: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MostPopularProductsScreen(),
                        ),
                      );
                    },
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DonateScreen(),
                        ),
                      );
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
