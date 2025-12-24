import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/widgets/bottom_nav_bar.dart';
import '../../screens/home/home_screen.dart';
import '../placeholder_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    PlaceholderScreen(title: 'Rent Cow'),
    PlaceholderScreen(title: 'Products'),
    PlaceholderScreen(title: 'Cart'),
    PlaceholderScreen(title: 'Profile'),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}
