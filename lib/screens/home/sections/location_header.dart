import 'package:flutter/material.dart';
import '../../../ui/common/app_colors.dart';

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
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        topPadding + 12,
        16,
        10,
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
                      Icons.arrow_back_ios_new,
                      size: 18,
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
    return Icon(icon, color: AppColors.white, size: 24);
  }
}
