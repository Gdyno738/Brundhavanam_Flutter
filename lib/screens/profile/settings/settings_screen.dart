import 'package:flutter/material.dart';
import '../../../ui/common/app_colors.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool whatsappUpdates = false;
  bool offerAlerts = false;
  bool pushNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      /// 🔝 APP BAR
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      /// 🧾 SETTINGS LIST
      body: Column(
        children: [
          _settingTile(
            title: 'Receive updates on WhatsApp',
            subtitle: 'Receive order details and updates on WhatsApp',
            value: whatsappUpdates,
            onChanged: (val) {
              setState(() => whatsappUpdates = val);
            },
          ),

          _divider(),

          _settingTile(
            title: 'Receive offer alerts',
            subtitle: 'Receive alerts in notifications',
            value: offerAlerts,
            onChanged: (val) {
              setState(() => offerAlerts = val);
            },
          ),

          _divider(),

          _settingTile(
            title: 'Push Notification',
            subtitle: '',
            value: pushNotification,
            onChanged: (val) {
              setState(() => pushNotification = val);
            },
          ),
        ],
      ),
    );
  }

  /// 🔹 SETTINGS TILE
  Widget _settingTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// TEXT SECTION
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),

          /// TOGGLE
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
            inactiveThumbColor: Colors.grey.shade300,
            inactiveTrackColor: Colors.grey.shade200,
          )

        ],
      ),
    );
  }

  /// 🔹 DIVIDER
  Widget _divider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFEAEAEA),
    );
  }
}
