import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import '../otp/otp_screen.dart';

class LoginBottomSheet extends StatefulWidget {
  final BuildContext rootContext;

  const LoginBottomSheet({
    super.key,
    required this.rootContext,
  });

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.5,
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.lightGrey),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 18,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// TITLE
          const Text(
            'For Every Ritual, A Sacred Companion',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 24),

          /// DIVIDER WITH TEXT
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _divider(left: true),
              const SizedBox(width: 10),
              const Text(
                'Log in or Sign up',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              const SizedBox(width: 10),
              _divider(left: false),
            ],
          ),

          const SizedBox(height: 32),

          /// MOBILE NUMBER FIELD
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.lightGrey),
            ),
            child: Row(
              children: [
                const Text(
                  '+91',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: 'Mobile Number',
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// GET OTP BUTTON
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                final mobile = mobileController.text.trim();

                if (mobile.length != 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter valid 10 digit mobile number'),
                    ),
                  );
                  return;
                }

                final parentContext = widget.rootContext;
                Navigator.pop(context);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(
                    parentContext,
                    MaterialPageRoute(
                      builder: (_) => OtpScreen(
                        mobileNumber: mobile,
                        parentContext: parentContext,
                      ),
                    ),
                  );
                });
              },
              child: const Text(
                'Get OTP',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// SKIP
          const Text(
            'Skip',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),

          const Spacer(),

          /// CONSENT
          const Text(
            'By proceeding, you consent to share your information with '
                'Brundhavanam and agree terms of service.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.2,
              letterSpacing: 0.12,
            ),
          ),
        ],
      ),
    );
  }

  /// GRADIENT DIVIDER
  Widget _divider({required bool left}) {
    return Container(
      width: 100,
      height: 1.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: left ? Alignment.centerLeft : Alignment.centerRight,
          end: left ? Alignment.centerRight : Alignment.centerLeft,
          colors: [
            AppColors.primary.withValues(alpha: 0.0),
            AppColors.primary,
          ],
        ),
      ),
    );
  }
}

/// ✅ GLOBAL FUNCTION (CORRECT PLACE)
void showLoginBottomSheet(BuildContext rootContext) {
  showModalBottomSheet(
    context: rootContext,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => LoginBottomSheet(
      rootContext: rootContext,
    ),
  );
}
