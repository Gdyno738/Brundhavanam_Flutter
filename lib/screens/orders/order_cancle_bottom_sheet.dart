import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'order_cancel_success_screen.dart';

class CancelOrderBottomSheet extends StatefulWidget {
  const CancelOrderBottomSheet({super.key});

  @override
  State<CancelOrderBottomSheet> createState() =>
      _CancelOrderBottomSheetState();
}

class _CancelOrderBottomSheetState extends State<CancelOrderBottomSheet> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _images = [];

  String? selectedReason;

  final List<String> reasons = [
    'Product no longer required',
    'Damage product',
    'Sent wrong product',
    'Others',
  ];

  /// 📸 Pick image
  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked =
    await _picker.pickImage(source: source, imageQuality: 70);

    if (picked != null) {
      setState(() => _images.add(File(picked.path)));
    }
  }

  /// 📸 Source chooser
  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cancel Booking',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// ORDER CARD (SIMPLIFIED)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F5F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Rent Cow',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  'Gruhapravesham',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                SizedBox(height: 6),
                Text(
                  '₹ 570/-',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          /// ISSUE TITLE
          const Text(
            'What is the issue with the product?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 12),

          /// REASONS (CUSTOM RADIO – NO DEPRECATION)
          Column(
            children: reasons.map((reason) {
              final isSelected = selectedReason == reason;

              return GestureDetector(
                onTap: () {
                  setState(() => selectedReason = reason);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF049150),
                          ),
                        ),
                        child: isSelected
                            ? Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Color(0xFF049150),
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        reason,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          /// ADD IMAGES
          const Text(
            'Add Images',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 10),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              /// UPLOAD BUTTON
              GestureDetector(
                onTap: _showImageSourceSheet,
                child: Container(
                  width: 136,
                  height: 105,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.5),
                      width: 0.5,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Upload Image',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),

              /// IMAGE PREVIEW
              ..._images.map((file) {
                return Stack(
                  children: [
                    Container(
                      width: 105,
                      height: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        image: DecorationImage(
                          image: FileImage(file),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _images.remove(file));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),

          const Spacer(),

          /// ACTION BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF049150), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(color: Color(0xFF049150)),
                ),
              ),
              ElevatedButton(
                onPressed: selectedReason == null
                    ? null
                    : () {
                  /// 1️⃣ Close cancel bottom sheet
                  Navigator.pop(context);

                  /// 2️⃣ Navigate to success screen AFTER sheet closes
                  Future.microtask(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OrderCancelSuccessScreen(),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF049150),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Cancel Order'),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
