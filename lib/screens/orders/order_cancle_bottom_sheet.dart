import 'dart:io';
import 'package:brundhavanam_app/screens/orders/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'order_cancel_success_screen.dart';

class CancelOrderBottomSheet extends StatefulWidget {
  final OrderModel order;

  const CancelOrderBottomSheet({
    super.key,
    required this.order,
  });

  @override
  State<CancelOrderBottomSheet> createState() => _CancelOrderBottomSheetState();
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

  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked =
    await _picker.pickImage(source: source, imageQuality: 70);

    if (picked != null) {
      setState(() => _images.add(File(picked.path)));
    }
  }

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
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// ORDER CARD
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F5F6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image(
                    image: widget.order.image != null
                        ? (widget.order.image!.startsWith('http')
                        ? NetworkImage(widget.order.image!)
                        : AssetImage(widget.order.image!)
                    as ImageProvider)
                        : const AssetImage('assets/images/placeholder.png'),
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.order.title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.order.subtitle,
                  style:
                  const TextStyle(fontSize: 10, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.order.price,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Ordered on 24 Dec 2025',
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
                const Text(
                  'Gachibowli, Hyd...',
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'What is the issue with the product?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 12),

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
                          border:
                          Border.all(color: const Color(0xFF049150)),
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
                      Text(reason,
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          const Text(
            'Add Images',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 10),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              GestureDetector(
                onTap: _showImageSourceSheet,
                child: Container(
                  width: 136,
                  height: 105,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.4),
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.image_outlined,
                          size: 28, color: Colors.black45),
                      SizedBox(height: 6),
                      Text(
                        'Upload Image',
                        style: TextStyle(
                            fontSize: 10, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),

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
                          child: const Icon(Icons.close,
                              size: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),

          const Spacer(),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Color(0xFF049150), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding:
                    const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(color: Color(0xFF049150)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: selectedReason == null
                      ? null
                      : () {
                    Navigator.pop(context);
                    Future.microtask(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const OrderCancelSuccessScreen(),
                        ),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF049150),
                    foregroundColor: Colors.white, // 👈 THIS makes text white
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Cancel order'),

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
