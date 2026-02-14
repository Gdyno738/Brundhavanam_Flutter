import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController addressDetailsController =
  TextEditingController();
  final TextEditingController phoneController =
  TextEditingController();

  bool showReceiverDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [

          /// HEADER
          SafeArea(
            bottom: false,
            child: Container(
              width: double.infinity,
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Select delivery location",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// MAP + STACK CONTENT
          Expanded(
            child: Stack(
              children: [

                Positioned.fill(
                  child: Image.asset(
                    "assets/images/map_placeholder01.png",
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  bottom: 320,
                  right: 16,
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
                            color: AppColors.primary, size: 16),
                        SizedBox(width: 6),
                        Text(
                          "current location",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          _roundedInput(
                            controller: searchController,
                            hint:
                            "Search for area, street name...",
                            icon: Icons.search,
                          ),

                          const SizedBox(height: 16),

                          Container(
                            padding:
                            const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(16),
                              border: Border.all(
                                  color:
                                  AppColors.lightGrey),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.location_on,
                                    color:
                                    AppColors.primary),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "DLF Cyber City, Indira Nagar, Gachibowli, Hyderabad",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color:
                                      AppColors.black,
                                    ),
                                  ),
                                ),
                                Icon(Icons.chevron_right),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          const Text(
                            "Address details*",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),

                          const SizedBox(height: 6),

                          _roundedInput(
                            controller:
                            addressDetailsController,
                            hint:
                            "Example: Floor, House no.",
                          ),

                          const SizedBox(height: 12),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showReceiverDetails =
                                !showReceiverDetails;
                              });
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                const Text(
                                  "Receiver details for this address",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color:
                                    AppColors.black,
                                  ),
                                ),
                                Icon(
                                  showReceiverDetails
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                ),
                              ],
                            ),
                          ),

                          if (showReceiverDetails) ...[
                            const SizedBox(height: 12),
                            _roundedInput(
                              controller:
                              phoneController,
                              hint:
                              "Aisha, 123456789",
                            ),
                          ],

                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton
                                  .styleFrom(
                                backgroundColor:
                                AppColors.primary,
                                shape:
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius
                                      .circular(16),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Save address",
                                style: TextStyle(
                                  color:
                                  AppColors.white,
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _roundedInput({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
        const TextStyle(color: AppColors.grey),
        prefixIcon:
        icon != null ? Icon(icon) : null,
        contentPadding:
        const EdgeInsets.symmetric(
            horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(16),
          borderSide: const BorderSide(
              color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(16),
          borderSide: const BorderSide(
              color: AppColors.primary),
        ),
      ),
    );
  }
}
