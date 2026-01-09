import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';

class UpiVerificationField extends StatefulWidget {
  const UpiVerificationField({super.key});

  @override
  State<UpiVerificationField> createState() => _UpiVerificationFieldState();
}

class _UpiVerificationFieldState extends State<UpiVerificationField> {
  final TextEditingController _controller = TextEditingController();

  bool showVerifyButton = false;
  bool isVerified = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TITLE
        const Text(
          'Enter UPI ID',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),

        const SizedBox(height: 8),

        /// INPUT / VERIFIED BOX
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isVerified
                ? const Color(0xFFC8FFE4) // light green
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isVerified
                  ? const Color(0xFF2ECC71)
                  : const Color(0xFFB7B1B1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  enabled: !isVerified,
                  onChanged: (value) {
                    if (value.isNotEmpty && !isVerified) {
                      setState(() => showVerifyButton = true);
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'example@upi',
                    hintStyle: TextStyle(color: AppColors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),

              /// VERIFIED ICON
              if (isVerified)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 16,
                    color: Color(0xFF049150),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        /// VERIFY BUTTON (APPEARS BELOW)
        if (showVerifyButton && !isVerified)
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF049150),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                setState(() {
                  isVerified = true;
                  showVerifyButton = false;
                });
              },
              child: const Text(
                'Verify UPI ID',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
