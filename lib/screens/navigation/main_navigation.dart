import 'package:brundhavanam_app/screens/category/category_grid_screen.dart';

import 'package:flutter/material.dart';

import '../../ui/widgets/bottom_nav_bar.dart';
import '../../screens/home/home_screen.dart';

import '../rentcow/RentCowScreen.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/profile/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;

  const MainNavigation({
    super.key,
    this.initialIndex = 0,
  });

  static final GlobalKey<MainNavigationState> navKey =
  GlobalKey<MainNavigationState>();

  @override
  State<MainNavigation> createState() => MainNavigationState();

  static void goToProductsTab(BuildContext context) {
    // Pop any open screens first
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }

    // Then switch to products tab
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navState = MainNavigation.navKey.currentState;
      if (navState != null && navState.mounted) {
        navState.switchTab(2);
      }
    });
  }
}

class MainNavigationState extends State<MainNavigation> {
  late int currentIndex;
  late final List<Widget> pages;
  String? productsInitialCategory;


  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;

    pages = [
      const HomeScreen(),
      const RentCowScreen(),

      /// ✅ CORRECT: null = ALL PRODUCTS
      const CategoryGridScreen(),

      const CartScreen(),
      const ProfileScreen(),
    ];
  }

  void switchTab(int index, {String? initialCategory}) {
    setState(() {
      currentIndex = index;

      if (index == 2) {
        productsInitialCategory = initialCategory;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (currentIndex != 0) {
          switchTab(0);
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: List.generate(pages.length, (index) {
            return Navigator(
              onGenerateRoute: (_) {
                return MaterialPageRoute(
                  builder: (_) => pages[index],
                );
              },
            );
          }),
        ),

        bottomNavigationBar: BottomNavBar(
          currentIndex: currentIndex,
          onTap: switchTab,
        ),
      ),
    );
  }
}