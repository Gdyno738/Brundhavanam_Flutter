import 'package:flutter/material.dart';

class CowTypeSelector extends StatelessWidget {
  final Function(String, List<String>) onSelect;


  const CowTypeSelector({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {


    final cows = [
      {
        'name': 'Gir Cow',
        'price': 700,
        'images': [
          'assets/images/gir.jpg',
          'assets/images/Sahiwal.png',
          'assets/images/gir.jpg',
          'assets/images/Sahiwal.png',
        ],
      },
      {
        'name': 'Sahiwal Cow',
        'price': 700,
        'images': [
          'assets/images/Sahiwal.png',
          'assets/images/Tharparkar.jpg',
          'assets/images/Sahiwal.png',
          'assets/images/Tharparkar.jpg',

        ],
      },
      {
        'name': 'Tharparkar Cow',
        'price': 700,
        'images': [
          'assets/images/Tharparkar.jpg',
          'assets/images/gir.jpg',
          'assets/images/Tharparkar.jpg',
          'assets/images/gir.jpg',
          'assets/images/Tharparkar.jpg',

        ],
      },
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
              onSelect(
                cow['name'] as String,
                List<String>.from(cow['images'] as List),
              );
              Navigator.pop(context);
            },

            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFFB7B1B1)),
              ),
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// IMAGE
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.asset(
                        (cow['images'] as List<String>).first,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// NAME
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      cow['name'] as String,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// PRICE
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Price : ₹${cow['price'] as int}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.green,
                      ),
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