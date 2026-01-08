import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ui/common/app_colors.dart';

class LocationPickerScreen extends StatelessWidget {
  const LocationPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locations = [
      'Gachibowli',
      'Hitech City',
      'Madhapur',
      'Kondapur',
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select location',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          /// 🔍 SEARCH
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for area, street...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.lightGrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          /// 📍 CURRENT LOCATION
          ListTile(
            leading: const Icon(Icons.my_location, color: AppColors.primary),
            title: const Text('Use current location'),
            onTap: () {
              Navigator.pop(context, 'Current Location');
            },
          ),

          const Divider(),

          /// 📌 SAVED LOCATIONS
          Expanded(
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (_, i) {
                return ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(locations[i]),
                  onTap: () => Navigator.pop(context, locations[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
