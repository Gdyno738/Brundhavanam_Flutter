import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import '../home/sections/location_header.dart';
import '../rentcow/rent_cow_content.dart';

class RentCowScreen extends StatelessWidget {
  const RentCowScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      body: SafeArea(
        child: Column(
          children: [
            /// 🔹 HEADER (fixed at top)
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
      ),
    );
  }
}
