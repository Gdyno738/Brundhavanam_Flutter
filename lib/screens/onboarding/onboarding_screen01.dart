import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/onboarding_model.dart';
import '../../ui/common/app_colors.dart';
import '../language/language_bottom_sheet.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;
  late BuildContext rootContext;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      image: 'assets/images/cow.jpg',
      title: 'Honor traditions the authentic way.',
      points: [
        'Cow & calf rent for house-warming and sacred ceremonies.',
        'Pure, peaceful, and handled with care.',
      ],
    ),
    OnboardingModel(
      image: 'assets/images/cow.jpg',
      title: 'Tradition delivered with trust.',
      points: [
        'Verified farmers and healthy cattle.',
        'Safe transport and on-time service.',
      ],
    ),
    OnboardingModel(
      image: 'assets/images/cow.jpg',
      title: 'Simple booking, divine experience.',
      points: [
        'Easy booking through the app.',
        'Support throughout your ceremony.',
      ],
    ),
  ];

  Future<void> _markOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
  }

  void _next() async {
    if (_index < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await _markOnboardingSeen();
      showLanguageSheet(rootContext);
    }
  }

  void _skip() async {
    await _markOnboardingSeen();
    showLanguageSheet(rootContext);
  }

  @override
  Widget build(BuildContext context) {
    rootContext = context;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: PageView.builder(
        controller: _controller,
        itemCount: pages.length,
        onPageChanged: (i) => setState(() => _index = i),
        itemBuilder: (_, i) {
          final isLast = i == pages.length - 1;
          final data = pages[i];

          return Stack(
            children: [
              /// 🔹 BACKGROUND IMAGE
              Positioned.fill(
                child: Image.asset(
                  data.image,
                  fit: BoxFit.cover,
                ),
              ),

              /// 🔹 LOGO (TOP RIGHT)
              Positioned(
                top: 40,
                right: 24,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Logo',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              /// 🔹 BOTTOM WHITE CARD
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isLast)
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: _skip,
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                      if (!isLast) const SizedBox(height: 12),

                      Text(
                        data.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 16),

                      ...data.points.map(
                            (p) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.check,
                                size: 18,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  p,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      if (isLast)
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _next,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        )
                      else
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: _next,
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              /// 🔙 BACK BUTTON (BOTTOM LEFT)
              /// 🔙 BACK BUTTON (BOTTOM LEFT – HIDDEN ON LAST SCREEN)
              if (_index > 0 && _index < pages.length - 1)
                Positioned(
                  left: 16,
                  bottom: 20,
                  child: GestureDetector(
                    onTap: () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),

              /// 🔘 DOTS (BOTTOM CENTER – HIDDEN ON LAST SCREEN)
              if (_index < pages.length - 1)
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                          (dotIndex) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _index == dotIndex
                              ? AppColors.primary
                              : AppColors.lightGrey,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
