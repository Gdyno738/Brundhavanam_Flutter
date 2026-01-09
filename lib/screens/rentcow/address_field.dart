import 'package:flutter/material.dart';
import '../../screens/home/sections/location_picker_screen.dart'; // adjust path if needed

class AddressField extends StatelessWidget {
  const AddressField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color(0xFFB7B1B1),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Address',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
              ),
            ),

            /// 👉 MAPS CLICK
            GestureDetector(
              onTap: () async {
                final selectedLocation = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LocationPickerScreen(),
                  ),
                );

                if (selectedLocation != null) {
                  debugPrint('Selected location: $selectedLocation');
                  // You can store this in state / controller later
                }
              },
              child: const Text(
                'Maps',
                style: TextStyle(
                  color: Color(0xFF049150),
                  fontSize: 14,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
