import 'package:flutter/material.dart';
import '../../models/SavedAddress.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/widgets/payment_success_screen.dart';
import '../home/sections/location_header.dart';
import '../rentcow/debit_credit.dart';
import '../rentcow/UpiVerificationField.dart';
import '../../services/mock_profile_service.dart';



class CartPayment extends StatefulWidget {
  const CartPayment({super.key});

  @override
  State<CartPayment> createState() => _CartPaymentState();
}

class _CartPaymentState extends State<CartPayment> {
  String selectedMethod = '';

  List<SavedAddress> addresses = [];
  SavedAddress? selectedAddress;


  @override
  void initState() {
    super.initState();
    loadAddresses();
  }

  Future<void> loadAddresses() async {
    final data = await MockProfileService.getSavedAddresses();
    setState(() {
      addresses = data;
      selectedAddress = data.isNotEmpty ? data.first : null;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// 🔹 HEADER
          LocationHeader(
            title: 'Payment Details',
            subtitle: selectedAddress?.address ?? 'Select address',
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
                    InkWell(
                      onTap: showAddressPicker,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              selectedAddress?.address ?? 'Select address',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
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

  void showAddressPicker() {
    if (addresses.isEmpty) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return ListView.builder(
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            final address = addresses[index];

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedAddress = address;
                });
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, color: AppColors.primary, size: 20),
                    const SizedBox(width: 10),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            address.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            address.address,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (selectedAddress == address)
                      const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
                  ],
                ),
              ),
            );

          },
        );
      },
    );
  }

}
