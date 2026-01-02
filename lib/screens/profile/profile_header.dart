import 'package:flutter/material.dart';
import '../../models/profile_model.dart';
import '../../services/mock_profile_service.dart';
import 'edit_profile_screen.dart';
import '../../../ui/common/app_colors.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  ProfileModel? profile;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final data = await MockProfileService.getProfile();
    setState(() => profile = data);
  }

  @override
  Widget build(BuildContext context) {
    if (profile == null) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(radius: 35),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile!.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500)),
                Text(profile!.address,
                    style: const TextStyle(color: AppColors.grey)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updated = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const EditProfileScreen()),
              );

              if (updated == true) {
                loadProfile(); // REFRESH
              }
            },
          ),
        ],
      ),
    );
  }
}
