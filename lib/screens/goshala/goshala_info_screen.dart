import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import '../home/sections/location_header.dart';
import 'goshala_live_tabs_screen.dart';

class GoshalaInfoScreen extends StatelessWidget {
  const GoshalaInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// HEADER
          LocationHeader(
            title: 'Goshala',
            subtitle: 'Indira Nagar, Gachibowli, Hyderabad',
            showBack: true,
            showDropdown: false,
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
                                builder: (_) =>
                                const GoshalaLiveScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 150),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'View Live',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
