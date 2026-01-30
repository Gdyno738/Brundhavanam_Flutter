import 'package:brundhavanam_app/ui/common/base_screen.dart';
import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import '../home/sections/location_header.dart';
import 'goshala_live_tabs_screen.dart';
import '../goshala/ViewLiveBadge.dart';
import '../donate/donate_screen.dart';
import '../../ui/widgets/become_partner_card.dart';

class GoshalaInfoScreen extends StatelessWidget {
  const GoshalaInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(

      child: Column(
        children: [
          /// HEADER
          const SafeArea(
            bottom: false,
            child: LocationHeader(
              title: 'Goshala',
              subtitle: 'Indira Nagar, Gachibowli, Hyderabad',
              showBack: true,
              showDropdown: false,
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔴 LIVE CAMERA BANNER
                  Stack(
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1593179357196-ea11a2e7c119',
                        height: 230,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      /// VIEW LIVE BUTTON
                      Positioned(
                        top: 16,
                        right: 16,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const GoshalaLiveScreen(),
                              ),
                            );
                          },
                          child: const ViewLiveBadge(),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// ABOUT SECTION
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'We are a dedicated goshala committed to the care, '
                          'protection, and well-being of cows while preserving '
                          'traditional values. We provide pure dairy products, '
                          'support rituals, and allow devotees to stay connected '
                          'through live monitoring.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.6,
                        color: AppColors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// GALLERY
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        _image(),
                        _image(),
                        _image(),
                        _image(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// 👉 BECOME PARTNER TITLE
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Become Partner',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 👉 BECOME PARTNER CARD
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BecomePartnerCard(
                      onDonateTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DonateScreen(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        'https://images.unsplash.com/photo-1546443046-ed1ce6ffd1ab',
        fit: BoxFit.cover,
      ),
    );
  }
}
