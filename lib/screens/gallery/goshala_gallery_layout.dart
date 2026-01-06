import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../ui/common/app_colors.dart';

class GoshalaGalleryLayout extends StatelessWidget {
  const GoshalaGalleryLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        itemCount: 7,
        itemBuilder: (context, index) {
          return _galleryTile(index);
        },
      ),
    );
  }

  Widget _galleryTile(int index) {
    /// Heights chosen to visually match your Figma layout
    final heights = [
      173.0,
      173.0,
      173.0,
      222.0,
      141.0,
      181.0,
      262.0,
    ];

    return Container(
      height: heights[index % heights.length],
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.lightGrey, // ✅ uses AppColors
      ),
    );
  }
}
