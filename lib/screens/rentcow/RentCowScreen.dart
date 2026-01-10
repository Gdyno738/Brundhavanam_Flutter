import 'package:flutter/material.dart';

import '../../ui/common/base_screen.dart';
import '../home/sections/location_header.dart';
import '../navigation/main_navigation.dart';
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
            onBack: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }

              WidgetsBinding.instance.addPostFrameCallback((_) {
                final navState = MainNavigation.navKey.currentState;
                if (navState != null) {
                  navState.switchTab(0); // 👈 Home tab
                }
              });
            },

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
