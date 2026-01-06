import 'package:flutter/material.dart';

import '../../ui/widgets/bottom_nav_bar.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/products/products_screen.dart';
import '../../ui/widgets/bottom_nav_bar.dart';
import '../placeholder_screen.dart';
import '../rentcow/RentCowScreen.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/placeholder_screen.dart';

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
}

class MainNavigationState extends State<MainNavigation> {
  late int currentIndex;
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      const HomeScreen(), // 0 → Home

      const RentCowScreen(), // 1 → Rent Cow (future)
    currentIndex = widget.initialIndex;

    pages = [
      const HomeScreen(),
      const PlaceholderScreen(title: 'Rent Cow'),
      ProductsScreen(
        initialCategory: 'Products',
        onBackToHome: () => switchTab(0),
      ),
      const CartScreen(),
      const ProfileScreen(),
    ];
  }

  void switchTab(int index) {
    if (index == currentIndex) return;
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: currentIndex == 0, // allow exit only on Home
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (currentIndex != 0) {
          switchTab(0);
        }
      },
      child: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavBar(
          currentIndex: currentIndex,
          onTap: switchTab,
        ),
      ),
    );
  }
}
