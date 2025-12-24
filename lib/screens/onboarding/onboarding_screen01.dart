import 'package:flutter/material.dart';
import '../../models/onboarding_model.dart';
import '../../ui/common/app_colors.dart';
import '../../screens/language/language_bottom_sheet.dart';

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

  void _next() {
    if (_index < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      showLanguageSheet(rootContext);
    }
  }

  void _skip() {
    showLanguageSheet(rootContext);
  }

  @override
  Widget build(BuildContext context) {
    rootContext = context;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: PageView.builder(
        controller: _controller,
        itemCount: pages.length,
        onPageChanged: (i) => setState(() => _index = i),
        itemBuilder: (context, i) {
          final bool isLast = i == pages.length - 1;
          final data = pages[i];

          return Stack(
            children: [
              /// IMAGE + DARK OVERLAY
              SizedBox(
                height: height * 0.65,
                width: double.infinity,
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: Tween<double>(begin: 1.05, end: 1.0)
                                .animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Image.asset(
                        data.image,
                        key: ValueKey(data.image),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),

                    /// DARK OVERLAY (FIGMA STYLE)
                    Container(
                      color: AppColors.black.withValues(alpha: 0.20),
                    ),
                  ],
                ),
              ),

              /// LOGO BADGE
              Positioned(
                right: 24,
                top: 40,
                child: Container(
                  width: 124,
                  height: 124,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 8,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Logo',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              /// SKIP (FLOATING)
              Positioned(
                right: 20,
                top: height * 0.58,
                child: GestureDetector(
                  onTap: _skip,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              /// WHITE CONTENT PANEL
              Positioned(
                top: height * 0.55,
                left: 0,
                right: 0,
                bottom: 0,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 500),
                  tween: Tween(begin: 40, end: 0),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, value),
                      child: child,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TITLE
                        Text(
                          data.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                            color: AppColors.black,
                          ),
                        ),

                        const SizedBox(height: 14),

                        /// BULLET POINTS
                        ...data.points.map(
                              (text) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    text,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: 1.4,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Spacer(),

                        /// BOTTOM ACTION
                        isLast
                            ? SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _next,
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                            : Row(
                          children: [
                            if (_index > 0)
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: AppColors.primary,
                                  size: 26,
                                ),
                                onPressed: () {
                                  _controller.previousPage(
                                    duration: const Duration(
                                        milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                              )
                            else
                              const SizedBox(width: 48),

                            /// DOTS
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: List.generate(
                                  pages.length,
                                      (d) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _index == d
                                          ? AppColors.primary
                                          : AppColors.lightGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            if (_index < pages.length - 1)
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.primary,
                                  size: 26,
                                ),
                                onPressed: _next,
                              )
                            else
                              const SizedBox(width: 48),
                          ],
                        ),
                      ],
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
