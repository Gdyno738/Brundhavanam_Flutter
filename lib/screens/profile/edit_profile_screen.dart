import 'package:flutter/material.dart';
import '../../../ui/common/app_colors.dart';
import '../../models/profile_model.dart';
import '../../services/mock_profile_service.dart';
import '../../screens/profile/settings/SavedAddressSection.dart';
import '../../ui/common/base_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final profile = await MockProfileService.getProfile();
    if (!mounted) return;

    setState(() {
      nameController.text = profile.name;
      phoneController.text = profile.phone;
      emailController.text = profile.email;
      addressController.text = profile.address;
    });
  }

  Future<void> saveProfile() async {
    final updated = ProfileModel(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      address: addressController.text.trim(),
    );

    await MockProfileService.updateProfile(updated);

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      statusBarIconBrightness: Brightness.dark,
      child: Column(
        children: [
          const SizedBox(height: 8),

          // Custom AppBar Row
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.black),
                onPressed: () => Navigator.pop(context),
              ),
              const Expanded(
                child: Text(
                  'Account details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.check, color: AppColors.black),
                onPressed: saveProfile,
              ),
            ],
          ),

          const SizedBox(height: 10),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _field(nameController, true),
                    _field(phoneController, false),
                    _field(emailController, true),
                    _field(addressController, true),
                    const SizedBox(height: 12),
                    const SavedAddressSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _field(TextEditingController controller, bool enabled) {
    return TextField(
      controller: controller,
      enabled: enabled,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
      ),
    );
  }
}
