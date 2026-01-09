import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';

import '../login/login_bottom_sheet.dart';
import '../navigation/main_navigation.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final BuildContext parentContext;

  const OtpScreen({
    super.key,
    required this.mobileNumber,
    required this.parentContext,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final int otpLength = 5;

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  bool isOtpComplete = false;

  @override
  void initState() {
    super.initState();
    controllers =
        List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes.first.requestFocus();
    });
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _checkOtpComplete() {
    final completed =
    controllers.every((controller) => controller.text.isNotEmpty);

    setState(() {
      isOtpComplete = completed;
    });
  }

  void _goBackToLogin() {
    Navigator.of(context).pop();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoginBottomSheet(widget.parentContext);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _goBackToLogin();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.black),
            onPressed: _goBackToLogin,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  'Need Help?',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 48),

              /// TITLE
              const Text(
                "Enter the OTP we’ve sent to",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              /// MOBILE NUMBER (UNDERLINED)
              Text(
                '+91 ${widget.mobileNumber}',
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                ),
              ),


              const SizedBox(height: 40),

              /// OTP BOXES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  otpLength,
                      (index) => _otpBox(index),
                ),
              ),

              const SizedBox(height: 60),

              /// VERIFY BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isOtpComplete
                        ? AppColors.primary
                        : AppColors.lightGrey,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: isOtpComplete
                      ? () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainNavigation(),
                      ),
                          (route) => false, // clears Splash, Login, OTP
                    );
                  }
                      : null,


                  child: Text(
                    'VERIFY OTP',
                    style: TextStyle(
                      color: isOtpComplete
                          ? AppColors.white
                          : AppColors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.36,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// RESEND TEXT
              Text(
                "Didn’t receive OTP? Get it on Whatsapp 0:59",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// OTP INPUT BOX (FIGMA SIZE)
  Widget _otpBox(int index) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < otpLength - 1) {
            focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
          _checkOtpComplete();
        },
      ),
    );
  }
}
