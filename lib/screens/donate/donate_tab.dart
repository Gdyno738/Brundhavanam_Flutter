import 'package:brundhavanam_app/ui/widgets/schedule_visit_banner.dart';
import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import 'become_partner_screen.dart';

class DonateTab extends StatelessWidget {
  final VoidCallback onDonateTap;

  const DonateTab({
    super.key,
    required this.onDonateTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 SCHEDULE VISIT BANNER
          const ScheduleVisitBanner(),

          const SizedBox(height: 24),

          /// 🔹 BECOME PARTNER TITLE
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              'Become Partner',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// 🔹 DESCRIPTION (Responsive)
          Text(
            'Support goshala with your contribution and be part of a tradition rooted in care, respect, and gratitude.',
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 24),

          /// 🔹 DONATION CARDS
          _donationCard(
            context,
            image: 'https://placehold.co/375x176',
            title: 'Donate for Green grass - ₹1,000 per Load',
          ),

          const SizedBox(height: 20),

          _donationCard(
            context,
            image: 'https://placehold.co/375x176',
            title: 'Donate for Dry fodder - ₹750',
          ),

          const SizedBox(height: 20),

          _donationCard(
            context,
            image: 'https://placehold.co/375x176',
            title: 'Donate for Cow Medical Care',
          ),

          const SizedBox(height: 30),

          /// 🔹 GENERAL DONATION
          const Text(
            'Donate in General',
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          _generalDonateSection(screenWidth),
        ],
      ),
    );
  }


  /// ================= DONATION CARD =================

  Widget _donationCard(BuildContext context, {
    required String image,
    required String title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        /// IMAGE CARD
        AspectRatio(
          aspectRatio: 16 / 7,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.lightGrey),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        /// TITLE
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(height: 12),

        /// DONATE BUTTON
        _donateButton(context),
      ],
    );
  }

  /// ================= DONATE BUTTON =================

  Widget _donateButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const BecomePartnerScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Donate',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }


  /// ================= GENERAL DONATE =================

  Widget _generalDonateSection(double screenWidth) {
    final qrSize = screenWidth * 0.7;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// QR IMAGE
          Container(
            height: qrSize,
            width: qrSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage('https://placehold.co/276x276'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 12,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// SCAN & PAY BUTTON
          GestureDetector(
            onTap: onDonateTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Scan & Pay',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}