import 'package:brundhavanam_app/ui/common/base_screen.dart';
import 'package:flutter/material.dart';

import '../../ui/common/app_colors.dart';
import '../donate/donate_tab.dart';
import '../gallery/goshala_gallery_layout.dart';
import '../home/sections/location_header.dart';
import 'donate/donate_history_layout.dart';
import 'quick_links.dart';
import 'goshala_section.dart';

class GoshalaLiveScreen extends StatefulWidget {
  const GoshalaLiveScreen({super.key});

  @override
  State<GoshalaLiveScreen> createState() => _GoshalaLiveScreenState();
}

class _GoshalaLiveScreenState extends State<GoshalaLiveScreen> {
  GoshalaSection _current = GoshalaSection.live;

  void goToDonateTab() {
    setState(() {
      _current = GoshalaSection.donate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          /// 🔝 HEADER
          LocationHeader(
            title: 'Goshala',
            subtitle: 'Indira Nagar, Gachibowli',
            showBack: true,
            showDropdown: false,
          ),

          const SizedBox(height: 12),

          /// 🔗 QUICK TABS
          QuickLinks(
            selected: _current,
            onChanged: (section) {
              setState(() {
                _current = section;
              });
            },
          ),

          const SizedBox(height: 12),

          /// 📦 CONTENT
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  /// ================= CONTENT SWITCH =================

  Widget _buildContent() {
    switch (_current) {
      case GoshalaSection.live:
        return _liveCameraLayout();

      case GoshalaSection.history:
        return const DonateHistoryLayout();


      case GoshalaSection.donate:
        return DonateTab(
          onDonateTap: goToDonateTab,);


      case GoshalaSection.gallery:
        return const GoshalaGalleryLayout();

    }
  }

  /// ================= LIVE CAMERA LAYOUT =================

  Widget _liveCameraLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// 🔝 BIG CAMERA
          _cameraTile(
            label: 'Cam 1',
            image:
            'https://images.unsplash.com/photo-1593179357196-ea11a2e7c119',
            height: 230,
          ),

          const SizedBox(height: 14),

          /// 🔽 TWO SMALL CAMERAS
          Row(
            children: [
              Expanded(
                child: _cameraTile(
                  label: 'Cam 2',
                  image:
                  'https://images.unsplash.com/photo-1546443046-ed1ce6ffd1ab',
                  height: 160,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _cameraTile(
                  label: 'Cam 3',
                  image:
                  'https://images.unsplash.com/photo-1500595046743-cd271d694d30',
                  height: 160,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ================= CAMERA TILE =================

  Widget _cameraTile({
    required String label,
    required String image,
    required double height,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        children: [
          /// IMAGE
          Image.network(
            image,
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          /// CAM LABEL (TOP LEFT)
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.glossBlack, // ✅ from AppColors
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 6,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// LIVE BADGE (BOTTOM RIGHT)
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 6,
                    color: Colors.white,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Live',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}