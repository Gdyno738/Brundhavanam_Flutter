import 'package:brundhavanam_app/screens/category/category_grid_screen.dart';
import 'package:flutter/material.dart';

import '../../ui/widgets/bottom_nav_bar.dart';
import '../../screens/home/home_screen.dart';
import '../rentcow/RentCowScreen.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/profile/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;
  final String? initialCategory; // 👈 add this

  const MainNavigation({
    super.key,
    this.initialIndex = 0,
    this.initialCategory,
  });

  @override
  State<MainNavigation> createState() => MainNavigationState();

  /// Navigate directly to Products tab
  static void goToProductsTab(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const MainNavigation(initialIndex: 2),
        ),
      );
    });
  }
}

class MainNavigationState extends State<MainNavigation> {
  late int currentIndex;
  late final List<Widget> pages;
  int previousIndex = 0;

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;

    pages = [
      const HomeScreen(),
      const RentCowScreen(),
      const CategoryGridScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
  }

    void switchTab(int index) {
    setState(() {
      previousIndex = currentIndex;
      currentIndex = index;
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
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              alignment: Alignment.center,
              children: [
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            );
          },
          transitionBuilder: (child, animation) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCubic,
            );

            final isProducts = currentIndex == 2;

            Offset beginOffset;

            if (isProducts) {
              beginOffset = const Offset(0, 0.25); // bottom
            } else if (currentIndex > previousIndex) {
              beginOffset = const Offset(0.25, 0); // right → left
            } else {
              beginOffset = const Offset(-0.25, 0); // left → right
            }

            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween(
                  begin: beginOffset,
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
          child: KeyedSubtree(
            key: ValueKey(currentIndex),
            child: pages[currentIndex],
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: currentIndex,
          onTap: switchTab,
        ),
      ),
    );
  }
}
