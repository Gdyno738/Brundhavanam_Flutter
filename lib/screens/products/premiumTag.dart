import 'package:flutter/material.dart';

class PremiumTag extends StatelessWidget {
  const PremiumTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.00, 0.50),
          end: Alignment(1.11, 0.50),
          colors: [
            Color(0xFFFFEBAC),
            Color(0xFFFFF8E1),
            Colors.white,
          ],
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.50,
            color: Color(0xFFFFECAD),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.verified, size: 18, color: Colors.orange),
          SizedBox(width: 7),
          Text(
            'Premium milk standards, everyday affordable pricing.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
