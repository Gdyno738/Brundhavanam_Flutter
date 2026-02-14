
import 'package:brundhavanam_app/screens/location/location_picker_screen.dart';
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
import '../category/category_products_screen.dart';
import '../donate/donate_screen.dart';



import '../navigation/main_navigation.dart';
import '../popularproducts/popular_products_screen.dart';
import '../location/location_header.dart';

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
                  const SizedBox(height: 10),

                  /// 🔍 Search bar
                  const HomeSearchBar(),

                  const SizedBox(height: 10),

                  /// 🥛 Section title
                  SectionHeader(
                    title: 'Dairy Products',
                    onViewAll: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const MainNavigation(initialIndex: 2),
                        ),
                      );
                    },


                  ),





                  /// 🧀 Category icons
                  // CategoryHorizontalList(
                  //   selectedCategory: selectedCategory ?? 'ALL',
                  //   onCategorySelected: (category) {
                  //     Navigator.of(context).pushReplacement(
                  //       MaterialPageRoute(
                  //         builder: (_) => const MainNavigation(
                  //           initialIndex: 2,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),

                  CategoryHorizontalList(
                    selectedCategory: selectedCategory ?? 'ALL',
                    onCategorySelected: (category) {
                      if (category == 'ALL') {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 450),
                            pageBuilder: (_, animation, secondaryAnimation) =>
                            const MainNavigation(initialIndex: 2),
                            transitionsBuilder: (_, animation, __, child) {
                              final curved = CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOutCubic,
                              );

                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.0, 1.0), // 👇 from bottom
                                  end: Offset.zero,
                                ).animate(curved),
                                child: child,
                              );
                            },
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 450),
                            pageBuilder: (_, animation, secondaryAnimation) =>
                                CategoryProductsScreen(category: category),
                            transitionsBuilder: (_, animation, __, child) {
                              final curved = CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOutCubic,
                              );

                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.0, 1.0), // 👇 from bottom
                                  end: Offset.zero,
                                ).animate(curved),
                                child: child,
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),









                  const SizedBox(height: 10),

                  /// 🎯 Banner carousel
                  const BannerCarousel(),

                  const SizedBox(height: 10),

                  /// 🔘 Filters
                  const FilterHorizontalList(),

                  const SizedBox(height: 10),

                  /// ⭐ MOST POPULAR PRODUCTS
                  MostPopularProductsSection(
                    onViewAll: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 450),
                          reverseTransitionDuration: const Duration(milliseconds: 450),
                          pageBuilder: (_, animation, secondaryAnimation) =>
                          const MostPopularProductsScreen(),
                          transitionsBuilder: (_, animation, __, child) {
                            final curved = CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutCubic,
                            );

                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1.0, 0.0), // 👉 from right
                                  end: Offset.zero,
                                ).animate(curved),
                                child: child,
                              ),
                            );
                          },
                        ),
                      );

                    },
                  ),





                  const SizedBox(height: 10),

                  /// 🟩 FULL WIDTH PROMO BANNER
                  const FullWidthBanner(),

                  const SizedBox(height: 10),

                  /// 🌱 FARM TO HOME TEXT
                  const FarmToHomeSection(),



                  const SizedBox(height: 10),

                  FarmVideoBanner(
                    videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                  ),

                  const SizedBox(height: 10),

                  const WhyTrustUsSection(),

                  const SizedBox(height: 10),

                  ContactSupportSection(),
                  const SizedBox(height: 10),

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

                  const SizedBox(height: 10),

                  BecomePartnerCard(
                    onDonateTap: () {
                      Navigator.push(
                        context,
                        _leftToRightRoute(const DonateScreen()),
                      );
                    },
                  ),



                  const SizedBox(height: 10),

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

                  const SizedBox(height: 10),

                  ReviewsHorizontalList(reviews: dummyReviews),

                  const SizedBox(height: 10),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Route _leftToRightRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 450),
    reverseTransitionDuration: const Duration(milliseconds: 450),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubic,
      );

      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0.0), // from left
          end: Offset.zero,
        ).animate(curved),
        child: child,
      );
    },
  );
}
