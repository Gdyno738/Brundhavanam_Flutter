import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ui/common/app_colors.dart';
import '../navigation/main_navigation.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController deliveryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    deliveryController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [

          /// 🔹 MAP BACKGROUND (Replace with GoogleMap later)
          Positioned.fill(
            child: Image.asset(
              "assets/images/map_placeholder01.png",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 TOP SEARCH BAR
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [

                  /// Back Button
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppColors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// Search Field
                  Expanded(
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search,
                              size: 20, color: AppColors.grey),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Search",
                              style: TextStyle(color: AppColors.grey),
                            ),
                          ),
                          Icon(Icons.mic,
                              size: 20, color: AppColors.grey),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🔹 CENTER PIN
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: const Text(
                    "Drag a Pin to choose location",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Icon(
                  Icons.location_pin,
                  color: AppColors.primary,
                  size: 42,
                ),
              ],
            ),
          ),

          /// 🔹 CURRENT LOCATION BUTTON
          Positioned(
            bottom: 280,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 6,
                  )
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.my_location,
                      size: 16, color: AppColors.primary),
                  SizedBox(width: 6),
                  Text(
                    "Current location",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🔹 BOTTOM FORM
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Receiver Name",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 6),

                  _inputField(
                    controller: nameController,
                    hint: "Enter receiver name",
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Delivery details",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 6),

                  _inputField(
                    controller: deliveryController,
                    hint: "DLF Cyber City, Indira Nagar...",
                  ),

                  const SizedBox(height: 16),

                  _inputField(
                    controller: addressController,
                    hint: "Address details*",
                  ),

                  const SizedBox(height: 20),

                  /// ✅ CONFIRM BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        if (nameController.text.trim().isEmpty ||
                            deliveryController.text.trim().isEmpty ||
                            addressController.text.trim().isEmpty) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please fill all details"),
                            ),
                          );

                          return;
                        }

                        /// Navigate and remove this screen
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MainNavigation(),
                          ),
                              (route) => false,
                        );
                      },

                      child: const Text(
                        "Confirm and Proceed",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.grey),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide:
          const BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide:
          const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
