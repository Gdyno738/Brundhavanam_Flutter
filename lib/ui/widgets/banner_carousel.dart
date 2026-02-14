import 'dart:async';
import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late final PageController _controller;
  int _currentIndex = 0;
  Timer? _timer;

  final List<String> banners = [
    'assets/bannerImages/home_banner1.png',
    'assets/bannerImages/home_banner2.png',
    'assets/bannerImages/banner3.png',
  ];

  @override
  void initState() {
    super.initState();

    _controller = PageController();

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_controller.hasClients) return;

      _currentIndex = (_currentIndex + 1) % banners.length;

      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Maintain Figma ratio 382 : 173
    final bannerWidth = screenWidth - 32;
    final bannerHeight = bannerWidth * (173 / 382);

    return Column(
      children: [
        /// 🔹 SINGLE FIXED CARD
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: bannerWidth,
            height: bannerHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
            ),
            clipBehavior: Clip.antiAlias,
            child: PageView.builder(
              controller: _controller,
              itemCount: banners.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (_, index) {
                return Image.asset(
                  banners[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: bannerHeight,
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 10),

        /// 🔘 Smaller Primary Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentIndex == index ? 8 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
