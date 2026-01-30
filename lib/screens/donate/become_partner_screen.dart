import 'package:brundhavanam_app/screens/rentcow/cart_payment.dart';
import 'package:brundhavanam_app/ui/common/base_screen.dart';
import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import '../home/sections/location_header.dart';

class BecomePartnerScreen extends StatefulWidget {
  const BecomePartnerScreen({super.key});

  @override
  State<BecomePartnerScreen> createState() => _BecomePartnerScreenState();
}

class _BecomePartnerScreenState extends State<BecomePartnerScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  String _category = 'Select Category';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _mobileCtrl.dispose();
    _addressCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  /// ✅ SUBMIT → NAVIGATE TO PAYMENT
  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const CartPayment(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(

      child: Column(
        children: [
          /// 🔝 HEADER
          LocationHeader(
            title: 'Donations',
            subtitle: '',
            showBack: true,
            showDropdown: false,
          ),

          /// 📦 FORM
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    const Text(
                      'Become Partner',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 24),

                    _inputField(
                      controller: _nameCtrl,
                      hint: 'Name',
                      validator: (v) =>
                      v!.isEmpty ? 'Enter your name' : null,
                    ),

                    const SizedBox(height: 16),

                    _inputField(
                      controller: _mobileCtrl,
                      hint: 'Mobile Number',
                      keyboard: TextInputType.phone,
                      maxLength: 10,
                      validator: (v) {
                        if (v!.isEmpty) return 'Enter mobile number';
                        if (v.length != 10) {
                          return 'Enter valid 10-digit number';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    _inputField(
                      controller: _addressCtrl,
                      hint: 'Address',
                      maxLines: 2,
                      validator: (v) =>
                      v!.isEmpty ? 'Enter address' : null,
                    ),

                    const SizedBox(height: 16),

                    _inputField(
                      controller: _emailCtrl,
                      hint: 'Email Id (optional)',
                      keyboard: TextInputType.emailAddress,
                      validator: (v) {
                        if (v!.isEmpty) return null;
                        if (!v.contains('@')) {
                          return 'Enter valid email';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    _categoryField(),

                    const SizedBox(height: 30),

                    /// 💚 PAY BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Pay Donation',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
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
    );
  }

  /// ================= INPUT FIELD =================
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
    int? maxLength,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: validator,
      decoration: InputDecoration(
        counterText: '',
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF888888)),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFFB7B1B1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFFB7B1B1)),
        ),
      ),
    );
  }

  /// ================= CATEGORY FIELD =================
  Widget _categoryField() {
    return GestureDetector(
      onTap: () async {
        final result = await showModalBottomSheet<String>(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) => _categorySheet(),
        );

        if (result != null) {
          setState(() => _category = result);
        }
      },
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFB7B1B1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _category,
              style: const TextStyle(
                color: Color(0xFF888888),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget _categorySheet() {
    final categories = [
      'Cow Care',
      'Feed Support',
      'Medical Help',
      'General Donation',
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: categories
            .map(
              (c) => ListTile(
            title: Text(c),
            onTap: () => Navigator.pop(context, c),
          ),
        )
            .toList(),
      ),
    );
  }
}
