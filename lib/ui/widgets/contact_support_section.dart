import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class ContactSupportSection extends StatelessWidget {
  const ContactSupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 172,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage('assets/bannerImages/support_banner.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            /// 🔲 DARK OVERLAY
            Container(
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            /// 📝 TEXT CONTENT
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Instant\ncustomer support,\npowered by AI',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Visiting hours\n9:00 am - 6:00 pm',
                    style: TextStyle(
                      color: Color(0xFFF6F6F6),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            /// 🟢 WHATSAPP BUTTON (MATCHING DESIGN POSITION)
            Positioned(
              left: 16,
              bottom: 14, // 👈 slightly above bottom
              child: GestureDetector(
                onTap: () {
                  debugPrint('WhatsApp clicked');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons/whatsapp_icon.png',
                        width: 16,
                        height: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Whatsapp',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
