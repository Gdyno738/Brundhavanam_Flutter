import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../screens/rentcow/cart_payment.dart';
import '../../ui/widgets/payment_success_screen.dart';

class TotalBillBottomSheet extends StatelessWidget {
  const TotalBillBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    final cowPrice = cart.cowItem?.price ?? 0.0;
    const deliveryCharge = 100.0;

    final total = cowPrice + deliveryCharge;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Drag indicator
          Container(
            width: 50,
            height: 5,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const Text(
            'Total bill',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF00341D),
            ),
          ),

          const SizedBox(height: 30),

          _row('Cow', '₹${cowPrice.toStringAsFixed(0)}/-'),
          const SizedBox(height: 12),
          _row('Delivery Charges', '₹${deliveryCharge.toStringAsFixed(0)}/-'),

          const SizedBox(height: 25),

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
              onPressed: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPayment(
                      type: PaymentType.rentCow,
                    ),
                  ),
                );
              },
              child: Text(
                'Pay ₹${total.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
