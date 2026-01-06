import 'dart:async';
import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  /// ✅ LOCAL ASSET IMAGES
  final List<String> banners = [
    'assets/bannerImages/banner1.png',
    'assets/bannerImages/banner2.png',
    'assets/bannerImages/banner3.png',
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_controller.hasClients) return;

      _currentIndex = (_currentIndex + 1) % banners.length;

      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      setState(() {});
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
    return Column(
      children: [
        /// 🖼️ BANNER
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    banners[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        /// 🔘 DOT INDICATOR
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentIndex == index ? 21 : 12,
              height: 12,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? AppColors.primary
                    : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
