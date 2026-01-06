import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';

class DonateTab extends StatelessWidget {
  final VoidCallback onDonateTap;

  const DonateTab({
    super.key,
    required this.onDonateTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _donationCard(
            image: 'https://placehold.co/375x176',
            title: 'Donate for Green grass - ₹1,000 per Load',
          ),
          const SizedBox(height: 20),

          _donationCard(
            image: 'https://placehold.co/375x176',
            title: 'Donate for Dry fodder - ₹750',
          ),
          const SizedBox(height: 20),

          _donationCard(
            image: 'https://placehold.co/375x176',
            title: 'Donate for Cow Medical Care',
          ),
          const SizedBox(height: 32),

          /// 🔹 GENERAL DONATION
          const Text(
            'Donate in General',
            style: TextStyle(
              color: Color(0xFF4D4D4D),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 24),

          _generalDonateSection(),
        ],
      ),
    );
  }

  /// ================= DONATION CARD =================

  Widget _donationCard({
    required String image,
    required String title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 176,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFCBC4C4),
              width: 0.5,
            ),
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

        const SizedBox(height: 12),

        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF252525),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 14),

        _donateButton(),
      ],
    );
  }

  /// ================= DONATE BUTTON =================

  Widget _donateButton() {
    return Container(
      width: 121,
      padding: const EdgeInsets.all(10),
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
    );
  }

  /// ================= GENERAL DONATE =================

  Widget _generalDonateSection() {
    return Column(
      children: [
        Container(
          height: 276,
          width: 276,
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

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
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
      ],
    );
  }
}
