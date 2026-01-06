import 'dart:ui';
import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class BecomePartnerCard extends StatefulWidget {
  final VoidCallback onDonateTap;

  const BecomePartnerCard({
    super.key,
    required this.onDonateTap,
  });

  @override
  State<BecomePartnerCard> createState() => _BecomePartnerCardState();
}

class _BecomePartnerCardState extends State<BecomePartnerCard> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _animate = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 220,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            /// 🌄 BACKGROUND IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/bannerImages/partner_bg.jpg',
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),

            /// 🌿 GRASS STRIP
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/grass_strip.png',
                height: 24,
                fit: BoxFit.cover,
              ),
            ),

            /// 🧊 GLASS CARD
            Positioned(
              right: 12,
              top: 16,
              bottom: 16,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutCubic,
                offset: _animate ? Offset.zero : const Offset(0.25, 0),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 700),
                  opacity: _animate ? 1 : 0,
                  child: _GlassPartnerCard(
                    onDonateTap: widget.onDonateTap,
                  ),
                ),
              ),
            ),

            /// 🐄 COW IMAGE
            Positioned(
              left: -10,
              bottom: 0,
              child: const _BreathingCow(),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////
/// 🐄 BREATHING COW
////////////////////////////////////////////////////////////////
class _BreathingCow extends StatefulWidget {
  const _BreathingCow();

  @override
  State<_BreathingCow> createState() => _BreathingCowState();
}

class _BreathingCowState extends State<_BreathingCow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _moveAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _moveAnim = Tween<double>(begin: 0, end: 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _moveAnim,
      builder: (_, child) {
        return Transform.translate(
          offset: Offset(0, -_moveAnim.value),
          child: child,
        );
      },
      child: Image.asset(
        'assets/images/cow_overlay.png',
        height: 155,
        fit: BoxFit.contain,
      ),
    );
  }
}

////////////////////////////////////////////////////////////////
/// 🧊 GLASS CARD
////////////////////////////////////////////////////////////////
class _GlassPartnerCard extends StatefulWidget {
  final VoidCallback onDonateTap;

  const _GlassPartnerCard({
    required this.onDonateTap,
  });

  @override
  State<_GlassPartnerCard> createState() => _GlassPartnerCardState();
}

class _GlassPartnerCardState extends State<_GlassPartnerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _opacityAnim = Tween<double>(begin: 0.16, end: 0.20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
        child: AnimatedBuilder(
          animation: _opacityAnim,
          builder: (_, __) {
            return Stack(
              children: [
                Container(
                  width: 198,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(
                      alpha: _opacityAnim.value,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: 0.30),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x55000000),
                        blurRadius: 18,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: _GlassContent(
                    onDonateTap: widget.onDonateTap,
                  ),
                ),

                /// ✨ LIGHT SWEEP
                Positioned.fill(
                  child: IgnorePointer(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (_, _) {
                        return FractionalTranslation(
                          translation:
                          Offset(-1 + (_controller.value * 2), 0),
                          child: Transform.rotate(
                            angle: -0.3,
                            child: Container(
                              width: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withValues(alpha: 0.0),
                                    Colors.white.withValues(alpha: 0.25),
                                    Colors.white.withValues(alpha: 0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////
/// 📝 GLASS CONTENT
////////////////////////////////////////////////////////////////
class _GlassContent extends StatelessWidget {
  final VoidCallback onDonateTap;

  const _GlassContent({
    required this.onDonateTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Be Part of Goshala',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Your contribution helps care for cows, support daily needs, '
              'and preserve a living tradition.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 12),

        /// 💚 DONATE BUTTON
        ElevatedButton(
          onPressed: onDonateTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            elevation: 3,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'Donate',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
