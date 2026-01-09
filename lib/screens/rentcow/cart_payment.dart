import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/widgets/payment_success_screen.dart';
import '../home/sections/location_header.dart';
import '../rentcow/debit_credit.dart';
import '../rentcow/UpiVerificationField.dart';

class CartPayment extends StatefulWidget {
  const CartPayment({super.key});

  @override
  State<CartPayment> createState() => _CartPaymentState();
}

class _CartPaymentState extends State<CartPayment> {
  String selectedMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// 🔹 HEADER
          LocationHeader(
            title: 'Payment Details',
            subtitle: 'Indira Nagar, Gachibowli, Hyderabad',
            showBack: true,
            showDropdown: false,
            onBack: () => Navigator.pop(context),
          ),

          /// 🔹 BODY
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment details',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _box(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          child: Text(
                            'Indira Nagar, Gachibowli, hyder...',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Image.asset(
                    'assets/images/upi.png',
                    height: 26,
                    width: 52,
                  ),

                  const SizedBox(height: 12),

                  _paymentTile('PhonePe', 'assets/images/phonepe.png'),
                  _paymentTile('G Pay', 'assets/images/gpay.png'),
                  _paymentTile('Paytm', 'assets/images/paytm.png'),

                  const SizedBox(height: 20),

                  const UpiVerificationField(),


                  const SizedBox(height: 30),

                  const Text(
                    'More ways to pay',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _paymentTile(
                    'Debit/Credit Card',
                    null,
                    showArrow: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DebitCredit(),
                        ),
                      );
                    },
                  ),

                  _paymentTile('Cash on Delivery', null),

                  const SizedBox(height: 30),

                  /// ✅ CONTINUE BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        if (selectedMethod.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                              Text('Please select a payment method'),
                            ),
                          );
                          return;
                        }

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );

                        await Future.delayed(const Duration(seconds: 2));

                        Navigator.pop(context);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const PaymentSuccessScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Continue',
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
        ],
      ),
    );
  }

  /// 🔹 COMMON BOX
  Widget _box(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  /// 🔹 PAYMENT TILE
  Widget _paymentTile(
      String title,
      String? image, {
        bool showArrow = false,
        VoidCallback? onTap,
      }) {
    final isSelected = selectedMethod == title;

    return GestureDetector(
      onTap: () {
        setState(() => selectedMethod = title);
        if (onTap != null) onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color:
            isSelected ? AppColors.primary : AppColors.grey,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 18,
              color: AppColors.primary,
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ),

            if (image != null)
              Image.asset(image, height: 22),

            if (showArrow) ...[
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ],
        ),
      ),
    );
  }
}
