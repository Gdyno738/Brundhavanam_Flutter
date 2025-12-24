import 'package:flutter/material.dart';
import '../../../ui/common/app_colors.dart';

class LocationHeader extends StatelessWidget {
  const LocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        left: 16,
        right: 16,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryDark,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// APP NAME
          const Text(
            'Brundhavanam',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 22,
              fontFamily: 'DynaPuff',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.22,
            ),
          ),

          const SizedBox(height: 12),

          /// LOCATION + ACTION ICONS
          Row(
            children: [

              /// LOCATION TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        const Text(
                          'DLF Cyber City',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ],
                    ),

                    const SizedBox(height: 2),

                    const Text(
                      'Indira Nagar, Gachibowli, Hyder...',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              /// ICONS (SEARCH / NOTIFICATION / PROFILE)
              Row(
                children: [
                  _icon(Icons.search),
                  const SizedBox(width: 14),
                  _icon(Icons.notifications_none),
                  const SizedBox(width: 14),
                  const CircleAvatar(
                    radius: 12,
                    backgroundImage:
                    NetworkImage('https://placehold.co/24x24'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _icon(IconData icon) {
    return Icon(
      icon,
      color: AppColors.white,
      size: 24,
    );
  }
}
