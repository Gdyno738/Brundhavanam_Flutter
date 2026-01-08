import 'package:flutter/material.dart';

import '../../ui/common/base_screen.dart';
import '../home/sections/location_header.dart';
import '../rentcow/rent_cow_content.dart';

class RentCowScreen extends StatelessWidget {
  const RentCowScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          LocationHeader(
              title: 'Rent Cow',
              subtitle: 'Indira Nagar, Gachibowli, Hyderabad',
              showBack: true,
              showDropdown: false,
              onBack: () => Navigator.pop(context),
            ),

            /// 🔹 CONTENT (scrollable)
            Expanded(
              child: SingleChildScrollView(
                child: const RentCowContent(),
              ),
            ),
          ],
        ),

    );
  }
}
