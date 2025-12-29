import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class WhyTrustUsSection extends StatelessWidget {
  const WhyTrustUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      /// ⬇️ REMOVE bottom padding so image touches edge
      padding: const EdgeInsets.only(top: 32),

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.white,
            Color(0xFFE7FFE8),
            Color(0xFFACFFB2),
          ],
        ),
      ),
      child: Column(
        children: [
          /// 🔰 TITLE
          const Text(
            'Why Customers Trust Us',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          /// 🔹 SUBTITLE
          const Text(
            'Short, clear, and reliable.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 32),

          /// 🔳 FEATURES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.start,
              spacing: 48,
              runSpacing: 36,
              children: const [
                _TrustItem(
                  title: 'Hygienic & Clean',
                  subtitle:
                  'Farm-fresh products handled with strict hygiene standards.',
                ),
                _TrustItem(
                  title: 'Trusted by Families',
                  subtitle:
                  'Thousands rely on us for pure dairy and sacred rituals.',
                ),
                _TrustItem(
                  title: 'Instant Support',
                  subtitle:
                  'Fast responses for bookings, queries, and customer care.',
                ),
                _TrustItem(
                  title: 'Fast Service',
                  subtitle:
                  'Quick delivery and timely cow rentals for every occasion.',
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          /// 🖼️ FULL-WIDTH IMAGE — TOUCHES BOTTOM
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              'assets/bannerImages/family_banner.png',
              width: double.infinity,
              height: 260,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrustItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _TrustItem({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.2,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              height: 1.2,
              letterSpacing: 0.1,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
