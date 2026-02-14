import 'package:brundhavanam_app/screens/feedback/feedback_screen.dart';
import 'package:brundhavanam_app/screens/profile/inviteFriend/invite_friend_inline.dart';
import 'package:brundhavanam_app/screens/profile/profile_header.dart';
import 'package:brundhavanam_app/screens/profile/settings/settings_screen.dart';
import 'package:flutter/material.dart';

import '../../ui/common/app_colors.dart';
import '../../ui/common/base_screen.dart';
import '../location/location_header.dart';
import '../navigation/main_navigation.dart';
import '../orders/your_orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showInviteBox = false;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          LocationHeader(
            title: 'Your profile',
            subtitle: '',
            showBack: true,
            showDropdown: false,
            onBack: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const MainNavigation(initialIndex: 0),
                ),
              );
            },

          ),

          /// 🔽 CONTENT (SCROLLABLE)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ProfileHeader(),
                  const SizedBox(height: 8),

                  profileMenuItem(
                    title: 'Your Orders',
                    onTap: () {
                      Navigator.push(
                        context,
                        _rightToLeftRoute(const YourOrdersScreen()),
                      );
                    },
                  ),

                  profileMenuItem(
                    title: 'Settings',
                    onTap: () {
                      Navigator.push(
                        context,
                        _rightToLeftRoute(const SettingsScreen()),
                      );
                    },
                  ),

                  profileMenuItem(
                    title: 'Feedback',
                    onTap: () {
                      Navigator.push(
                        context,
                        _rightToLeftRoute(const FeedbackScreen()),
                      );
                    },
                  ),

                  /// 👇 INVITE A FRIEND (INLINE)
                  profileMenuItem(
                    title: 'Invite a Friend',
                    trailing: AnimatedRotation(
                      turns: _showInviteBox ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 250),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.grey,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _showInviteBox = !_showInviteBox;
                      });
                    },
                  ),


                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    child: _showInviteBox
                        ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: InviteFriendInline(),
                    )
                        : const SizedBox(),
                  ),

                ],
              ),
            ),
          ),

          /// 🔻 LOGOUT BUTTON
          Padding(
            padding: const EdgeInsets.all(16),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                side: const BorderSide(color: AppColors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.logout, color: AppColors.black),
              label: const Text(
                'Logout',
                style: TextStyle(color: AppColors.black),
              ),
            ),
          ),
        ],
      ),

    );
  }

  /// 🔹 MENU ITEM BUILDER
  Widget profileMenuItem({
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          trailing: trailing ??
              const Icon(
                Icons.chevron_right,
                color: AppColors.grey,
              ),
          onTap: onTap,
        ),
        const Divider(height: 1, color: AppColors.lightGrey),
      ],
    );
  }

  Route _rightToLeftRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, animation, secondaryAnimation) => page,
      transitionsBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0), // 👉 from right
            end: Offset.zero,
          ).animate(curved),
          child: child,
        );
      },
    );
  }
}
