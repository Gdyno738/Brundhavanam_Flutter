import 'package:flutter/material.dart';
import '../home/sections/location_header.dart';

class OtpPayment extends StatefulWidget {
  const OtpPayment({super.key});

  @override
  State<OtpPayment> createState() => _OtpPaymentState();
}

class _OtpPaymentState extends State<OtpPayment> {
  final TextEditingController pinController = TextEditingController();
  final List<TextEditingController> otpControllers =
  List.generate(4, (_) => TextEditingController());

  void _onPay() {
    final pin = pinController.text.trim();
    final otp = otpControllers.map((e) => e.text).join();

    // ✅ PIN can be 4 OR 6 digits
    if (!(pin.length == 4 || pin.length == 6)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PIN must be 4 or 6 digits'),
        ),
      );
      return;
    }

    // ✅ OTP must be 4 digits
    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 4-digit OTP'),
        ),
      );
      return;
    }

    // ✅ Demo success
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment Successful')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [

          /// 🔹 HEADER
          LocationHeader(
            title: 'Payment',
            subtitle: 'Indira Nagar, Gachibowli, Hyderabad',
            showBack: true,
            showDropdown: false,
            onBack: () => Navigator.pop(context),
          ),

          /// 🔹 CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'Enter Debit/Credit Card details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// PIN LABEL
                  const Text(
                    'Pin',
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// PIN FIELD (4 OR 6 DIGITS)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFB7B1B1)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: pinController,
                      obscureText: true,
                      maxLength: 6, // allow up to 6
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Color(0xFF888888),
                        fontSize: 16,
                        letterSpacing: 5,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'XXXX / XXXXXX',
                        hintStyle: TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 18,
                          letterSpacing: 5,
                          fontWeight: FontWeight.w500,
                        ),
                        counterText: '',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// OTP LABEL
                  const Text(
                    'OTP',
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// OTP BOXES (4 DIGITS)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                          (index) => Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFB7B1B1)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          controller: otpControllers[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// PAY BUTTON
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
                      onPressed: _onPay,
                      child: const Text(
                        'Pay',
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
}
