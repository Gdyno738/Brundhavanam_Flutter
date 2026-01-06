import 'package:flutter/material.dart';

class CowTypeSelector extends StatelessWidget {
  final Function(String, String) onSelect;

  const CowTypeSelector({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final cows = [
      {'name': 'Gir Cow', 'image': 'assets/images/gir.jpg'},
      {'name': 'Sahiwal Cow', 'image': 'assets/images/Sahiwal.png'},
      {'name': 'Tharparkar', 'image': 'assets/images/Tharparkar.jpg'},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      height: 350,

      // ✅ BACKGROUND COLOR (NOT DEFAULT WHITE)
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F2), // 👈 same as EventDropdown
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),

      child: GridView.builder(
        itemCount: cows.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final cow = cows[index];

          return GestureDetector(
            onTap: () {
              onSelect(cow['name']!, cow['image']!);
              Navigator.pop(context);
            },
            child: Card(
              // ✅ CARD BACKGROUND COLOR
              color: Colors.white,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(
                  color: Color(0xFFB7B1B1),
                ),
              ),

              elevation: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    cow['image']!,
                    height: 90,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    cow['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
