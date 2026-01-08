import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import '../home/sections/location_header.dart';
import 'donate_tab.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          /// 🔝 HEADER
          LocationHeader(
            title: 'Donations',
            subtitle: '',
            showBack: true,
            showDropdown: false,
            onBack: () => Navigator.pop(context),
          ),

          /// 📦 CONTENT
          const Expanded(
            child: DonateTab(
              onDonateTap: _noop,
            ),
          ),
        ],
      ),
    );
  }

  /// DonateTab requires a callback, but not needed here
  static void _noop() {}
}
