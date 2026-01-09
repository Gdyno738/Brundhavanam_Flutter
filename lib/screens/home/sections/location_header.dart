import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../ui/common/app_colors.dart';
import '../../chat/chat_screen.dart';
import '../../wishlist/wish_list_screen.dart';
import '../../goshala/goshala_info_screen.dart';

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
      _arrowController.forward();
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
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Container(
          width: double.infinity,
          color: AppColors.primary,
          padding: EdgeInsets.fromLTRB(16, topInset + 12, 16, 12),
          child: Column(
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
                  if (widget.showBack)
                    GestureDetector(
                      onTap: widget.onBack ?? () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.arrow_back,
                          size: 22,
                          color: AppColors.white,
                        ),
                      ),
                    ),

                  /// 📍 LOCATION AREA (CLICKABLE)
                  Expanded(
                    child: InkWell(
                      onTap:
                      widget.showLocationIcon ? _handleLocationTap : null,
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (widget.showLocationIcon)
                                const Icon(
                                  Icons.location_on,
                                  size: 20,
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              if (widget.showDropdown)
                                RotationTransition(
                                  turns: Tween(begin: 0.0, end: 0.5)
                                      .animate(_arrowController),
                                  child: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.white,
                                  ),
                                ),
                            ],
                          ),

                          if (widget.subtitle.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(
                                left: widget.showLocationIcon ? 24 : 0,
                              ),
                              child: Text(
                                widget.subtitle,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
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
                            MaterialPageRoute(
                                builder: (_) => const ChatScreen()),
                          );
                        },
                      ),
                      const SizedBox(width: 14),
                      _iconButton(
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
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/icons/rent_cow.png',
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
