import 'package:flutter/material.dart';
import '../home/sections/location_header.dart';
import '../rentcow/debit_credit.dart';

class CartPayment extends StatefulWidget {
  const CartPayment({super.key});

  @override
  State<CartPayment> createState() => _CartPaymentState();
}

class _CartPaymentState extends State<CartPayment> {
  String selectedMethod = 'PhonePe';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [

          /// 🔹 FIXED HEADER
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

                  /// PAYMENT DETAILS TITLE
                  const Text(
                    'Payment details',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 12),

                  /// ADDRESS
                  _box(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          child: Text(
                            'Indira Nagar, Gachibowli, hyder...',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🔹 UPI LOGO
                  Image.asset(
                    'assets/images/upi.png',
                    height: 26,
                    width: 52,
                    fit: BoxFit.cover,
                  ),

                  const SizedBox(height: 12),

                  /// 🔹 UPI OPTIONS
                  _paymentTile('PhonePe', 'assets/images/phonepe.png'),
                  _paymentTile('G Pay', 'assets/images/gpay.png'),
                  _paymentTile('Paytm', 'assets/images/paytm.png'),

                  const SizedBox(height: 20),

                  /// ENTER UPI ID
                  const Text(
                    'Enter UPI ID',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),

                  _box(
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'example@upi',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// MORE WAYS
                  const Text(
                    'More ways to pay',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),

                  /// DEBIT / CREDIT (NO IMAGE USED)
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

                  /// CONTINUE BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF049150),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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
        border: Border.all(color: const Color(0xFFB7B1B1)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  /// 🔹 PAYMENT TILE WITH RADIO + NAVIGATION
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
            color: isSelected
                ? const Color(0xFF049150)
                : const Color(0xFFB7B1B1),
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
              color: const Color(0xFF049150),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            if (image != null)
              Image.asset(
                image,
                height: 22,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),

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
