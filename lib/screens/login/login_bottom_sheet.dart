import 'package:brundhavanam_app/screens/navigation/main_navigation.dart';
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
          /// MOBILE NUMBER FIELD (PROPERLY ALIGNED)
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.lightGrey),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// +91
                const Text(
                  '+91',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(width: 20),

                /// MOBILE NUMBER
                Expanded(
                  child: TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,

                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),

                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: AppColors.primary,

                    decoration: const InputDecoration(
                      counterText: '',
                      isDense: true, // 🔥 KEY FIX
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

                Navigator.of(context).pop(); // Close sheet

                Navigator.of(context, rootNavigator: true).push(
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 400),
                    pageBuilder: (_, animation, secondaryAnimation) =>
                        OtpScreen(
                          mobileNumber: mobile,
                          parentContext: context,
                        ),
                    transitionsBuilder: (_, animation, secondaryAnimation, child) {
                      const begin = Offset(0, 1);
                      const end = Offset.zero;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: Curves.easeOutCubic));

                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        ),
                      );
                    },

                  ),
                );
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
          GestureDetector(onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (_, animation, secondaryAnimation) =>
                const MainNavigation(initialIndex: 0),
                transitionsBuilder: (_, animation, secondaryAnimation, child) {
                  final curved = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOutCubic,
                  );

                  return SlideTransition(
                    position: Tween(
                      begin: const Offset(-1.0, 0.0), // from left
                      end: Offset.zero,
                    ).animate(curved),
                    child: child,
                  );
                },
              ),
                  (route) => false,
            );

          },


            child: const Text(
              'Skip',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
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
    showDragHandle: true,
    useSafeArea: true,
    builder: (context) {
      return TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        tween: Tween(begin: 40, end: 0),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, value),
            child: child,
          );
        },
        child: LoginBottomSheet(
          rootContext: rootContext,
        ),
      );
    },
  );
}


