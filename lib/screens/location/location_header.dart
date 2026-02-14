import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../ui/common/app_colors.dart';
import '../chat/chat_screen.dart';
import '../wishlist/wish_list_screen.dart';
import '../goshala/goshala_info_screen.dart';

class LocationHeader extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool showBack;
  final bool showDropdown;
  final bool showLocationIcon;
  final VoidCallback? onBack;
  final VoidCallback? onLocationTap; // ✅ NEW

  const LocationHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBack = false,
    this.showDropdown = true,
    this.showLocationIcon = false,
    this.onBack,
    this.onLocationTap,
  });

  @override
  State<LocationHeader> createState() => _LocationHeaderState();
}

class _LocationHeaderState extends State<LocationHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _arrowController;

  @override
  void initState() {
    super.initState();
    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  void _handleLocationTap() {
    if (widget.showDropdown) {
      if (_arrowController.isCompleted) {
        _arrowController.reverse();
      } else {
        _arrowController.forward();
      }
    }
    widget.onLocationTap?.call();
  }


  @override
  void dispose() {
    _arrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double topInset = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Container(
        width: double.infinity,
        color: AppColors.primary,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 2, 16, 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Brundhavanam',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20, // slightly reduced
                    fontFamily: 'DynaPuff',
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8), // reduced spacing

                Row(
                  children: [
                    if (widget.showBack)
                      GestureDetector(
                        onTap:
                        widget.onBack ?? () => Navigator.pop(context),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.arrow_back,
                            size: 20,
                            color: AppColors.white,
                          ),
                        ),
                      ),

                    Expanded(
                      child: InkWell(
                        onTap: widget.showLocationIcon
                            ? _handleLocationTap
                            : null,
                        borderRadius: BorderRadius.circular(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                if (widget.showLocationIcon)
                                  const Icon(
                                    Icons.location_on,
                                    size: 18,
                                    color: AppColors.white,
                                  ),
                                if (widget.showLocationIcon)
                                  const SizedBox(width: 4),

                                Flexible(
                                  child: Text(
                                    widget.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                if (widget.showDropdown)
                                  AnimatedBuilder(
                                    animation: _arrowController,
                                    builder: (context, child) {
                                      return Icon(
                                        _arrowController.isCompleted
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        size: 18,
                                        color: AppColors.white,
                                      );
                                    },
                                  ),

                              ],
                            ),

                            if (widget.subtitle.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(
                                  left:
                                  widget.showLocationIcon ? 22 : 0,
                                ),
                                child: Text(
                                  widget.subtitle,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        _iconButton(
                          iconPath: 'assets/icons/chat.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              _leftToRightRoute(
                                  const ChatScreen()),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        _iconButton(
                          iconPath:
                          'assets/icons/wishlist_outlined.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              _leftToRightRoute(
                                  const WishlistScreen()),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        _profileButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              _leftToRightRoute(
                                  const GoshalaInfoScreen()),
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
      ),
    );

  }

  Widget _iconButton({
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

  Widget _profileButton({required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 60,   // 👈 SAME FOR ALL ICONS
        height: 60,
        alignment: Alignment.center,
        child: Image.asset(
          'assets/icons/cow.png',
          width: 80,  // image size
          height: 80,
          fit: BoxFit.contain,
        ),
      ),
    );

  }
}
Route _leftToRightRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 450),
    reverseTransitionDuration: const Duration(milliseconds: 450),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubic,
      );

      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0.0), // 👈 from left
          end: Offset.zero,
        ).animate(curved),
        child: child,
      );
    },
  );
}
