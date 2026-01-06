import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../ui/common/app_colors.dart';
import '../../chat/chat_screen.dart';
import '../../wishlist/wish_list_screen.dart';
import '../../goshala/goshala_info_screen.dart';

class LocationHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBack;
  final bool showDropdown;
  final VoidCallback? onBack;

  const LocationHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBack = false,
    this.showDropdown = true,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final double topInset = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.primary, // 🔥 THIS REMOVES WHITE BAR
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark, // iOS
      ),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Container(
          width: double.infinity,
          color: AppColors.primary,
          padding: EdgeInsets.fromLTRB(
            16,
            topInset + 12,
            16,
            12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Brundhavanam',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 22,
                  fontFamily: 'DynaPuff',
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  if (showBack)
                    GestureDetector(
                      onTap: onBack ?? () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.arrow_back,
                          size: 22,
                          color: AppColors.white,
                        ),
                      ),
                    ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (showDropdown)
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.white,
                              ),
                          ],
                        ),
                        if (subtitle.isNotEmpty)
                          Text(
                            subtitle,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      _iconButton(
                        context,
                        iconPath: 'assets/icons/chat.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ChatScreen()),
                          );
                        },
                      ),
                      const SizedBox(width: 14),
                      _iconButton(
                        context,
                        iconPath: 'assets/icons/wishlist.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const WishlistScreen()),
                          );
                        },
                      ),
                      const SizedBox(width: 14),
                      _profileButton(
                        context,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const GoshalaInfoScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(
      BuildContext context, {
        required String iconPath,
        required VoidCallback onTap,
      }) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Image.asset(
          iconPath,
          width: 24,
          height: 24,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _profileButton(
      BuildContext context, {
        required VoidCallback onTap,
      }) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/icons/cow.png',
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
