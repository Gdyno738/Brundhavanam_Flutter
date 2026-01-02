import 'package:flutter/material.dart';

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'About Us',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'We are a dedicated goshala committed to the care, protection, and '
              'well-being of cows while preserving traditional values. Through our '
              'services, we support sacred rituals, provide pure and high-quality '
              'milk products, and create a transparent way for people to stay '
              'connected with our cows. By combining tradition with technology, '
              'we invite families and devotees to become part of our mission '
              'supporting cows with compassion, responsibility, and respect.',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w300,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
