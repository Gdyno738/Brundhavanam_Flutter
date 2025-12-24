import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import '../../screens/login/login_bottom_sheet.dart';

class LanguageBottomSheet extends StatefulWidget {
  final BuildContext rootContext;

  const LanguageBottomSheet({
    super.key,
    required this.rootContext,
  });

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.5,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
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
            'Select your Language',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),

          const SizedBox(height: 28),

          /// DIVIDER WITH TEXT — "choose an option"
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _divider(left: true),
              const SizedBox(width: 10),
              const Text(
                'choose an option',
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

          /// LANGUAGE OPTIONS
          Row(
            children: [
              _languageButton(
                text: 'English',
                isSelected: selectedLanguage == 'en',
                onTap: () => setState(() => selectedLanguage = 'en'),
              ),
              const SizedBox(width: 20),
              _languageButton(
                text: 'తెలుగు',
                isSelected: selectedLanguage == 'te',
                onTap: () => setState(() => selectedLanguage = 'te'),
              ),
            ],
          ),

          const Spacer(),

          /// CONTINUE BUTTON
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
              onPressed: selectedLanguage == null
                  ? null
                  : () {
                Navigator.pop(context);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showLoginBottomSheet(widget.rootContext);
                });
              },
              child: const Text(
                'Continue',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 150),

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

  /// DIVIDER LINE (LEFT & RIGHT OF TEXT)
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


  /// LANGUAGE BUTTON
  Widget _languageButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: SizedBox(
        height: 48,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor:
            isSelected ? AppColors.primary : Colors.transparent,
            side: BorderSide(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.lightGrey,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.black,
              fontSize: text == 'తెలుగు' ? 24 : 20,
              fontWeight:
              text == 'తెలుగు' ? FontWeight.w500 : FontWeight.w600,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }


/// SHOW LANGUAGE SHEET (LOGIC UNCHANGED)
void showLanguageSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => LanguageBottomSheet(
      rootContext: context,
    ),
  );
}
