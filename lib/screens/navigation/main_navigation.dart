import 'package:flutter/material.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/products/products_screen.dart';
import '../../ui/widgets/bottom_nav_bar.dart';
import '../placeholder_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      const HomeScreen(), // 0 → Home

      const Placeholder(), // 1 → Rent Cow (future)

      ProductsScreen(     // 2 → Products ✅ FIXED
        initialCategory: 'Products',
        onBackToHome: () {
          setState(() => currentIndex = 0);
        },
      ),

      const Placeholder(), // 3 → Cart
      const Placeholder(), // 4 → Profile
    ];
  }

  void switchTab(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: switchTab,
      ),
    );
  }
}
