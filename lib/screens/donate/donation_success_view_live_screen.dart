import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import '../goshala/goshala_live_tabs_screen.dart';
import '../location/location_header.dart';


class DonationSuccessViewLiveScreen extends StatelessWidget {
  const DonationSuccessViewLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          /// 🔝 HEADER
          LocationHeader(
            title: 'Donation Successful',
            subtitle: '',
            showBack: true,
            showDropdown: false,
          ),

          /// 📦 BODY
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// 🖼️ IMAGE
                  Container(
                    width: double.infinity,
                    height: 276,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://placehold.co/412x276',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// 📝 MESSAGE
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'As a donator, you become part of our goshala family. '
                          'Your support helps provide daily care, nourishment, '
                          'and protection for our cows while preserving a living '
                          'tradition of compassion and respect.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// ▶️ VIEW LIVE BUTTON
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const GoshalaLiveScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 267,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'View Live',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
