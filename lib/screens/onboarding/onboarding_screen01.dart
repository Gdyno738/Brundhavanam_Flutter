import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/onboarding_model.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/common/base_screen.dart';
import '../language/language_bottom_sheet.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;
  //late BuildContext rootContext;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      image: 'assets/images/cow-calf.png',
      title: 'Honor traditions the authentic way.',
      points: [
        'Cow & calf rent for house-warming and sacred ceremonies.',
        'Pure, peaceful, and handled with care.',
      ],
    ),
    OnboardingModel(
      image: 'assets/images/onboarding_milk.png',
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
      _controller.animateToPage(
        _index + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      await _markOnboardingSeen();

      if (!mounted) return;

      showLanguageSheet(context);
    }
  }


  void _skip() async {
    await _markOnboardingSeen();

    if (!mounted) return;

    showLanguageSheet(context);
  }


  @override
  Widget build(BuildContext context) {
    //rootContext = context;

    return BaseScreen(
      child: PageView.builder(
        reverse: true,
        controller: _controller,
        itemCount: pages.length,
        onPageChanged: (i) => setState(() => _index = i),
        itemBuilder: (_, i) {
          final isLast = i == pages.length - 1;
          final data = pages[i];

          return Column(
            children: [

              /// 🔹 TOP IMAGE (RESTORED)
              Expanded(
                flex: 6,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        data.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),

              /// 🔹 TEXT SECTION (UNCHANGED UI)
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// 🔹 TOP ROW (BACK + SKIP)
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


                      const SizedBox(height: 20),

                      Text(
                        data.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 16),

                      ...data.points.map(
                            (p) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
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

                      const Spacer(),

                      /// 🔹 NAVIGATION SECTION
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          /// 🔸 ARROWS + DOTS (Always visible)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              /// BACK BUTTON
                              if (_index > 0)
                                GestureDetector(
                                  onTap: () {
                                    _controller.animateToPage(
                                      _index - 1,
                                      duration: const Duration(milliseconds: 400),
                                      curve: Curves.easeInOutCubic,
                                    );
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    size: 28,
                                    color: AppColors.primary,
                                  ),
                                )
                              else
                                const SizedBox(width: 28),

                              /// DOTS (Always visible)
                              Row(
                                children: List.generate(
                                  pages.length,
                                      (dotIndex) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    width: _index == dotIndex ? 20 : 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: _index == dotIndex
                                          ? AppColors.primary
                                          : AppColors.lightGrey,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),

                              /// FORWARD BUTTON (Hidden only on last screen)
                              if (!isLast)
                                GestureDetector(
                                  onTap: () {
                                    _controller.animateToPage(
                                      _index + 1,
                                      duration: const Duration(milliseconds: 400),
                                      curve: Curves.easeInOutCubic,
                                    );
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    size: 28,
                                    color: AppColors.primary,
                                  ),
                                )
                              else
                                const SizedBox(width: 28),
                            ],
                          ),

                          const SizedBox(height: 28),

                          /// 🔸 GET STARTED BUTTON (Only Last Screen)
                          if (isLast)
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () async {
                                  await _markOnboardingSeen();
                                  if (!mounted) return;
                                  showLanguageSheet(context);
                                },
                                child: const Text(
                                  "Get Started",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),



                    ],
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
