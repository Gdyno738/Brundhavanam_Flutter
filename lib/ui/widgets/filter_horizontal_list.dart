import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class FilterHorizontalList extends StatefulWidget {
  const FilterHorizontalList({super.key});

  @override
  State<FilterHorizontalList> createState() => _FilterHorizontalListState();
}

class _FilterHorizontalListState extends State<FilterHorizontalList> {
  String selectedFilter = 'Filter';

  final List<String> filters = [
    'Filter',
    '500 ml',
    '20% off',
    'Combo',
    '50% off',
    '2 Liter',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) {
          final filter = filters[index];
          final isSelected = filter == selectedFilter;

          return GestureDetector(
            onTap: () {
              setState(() => selectedFilter = filter);

              // 🔗 BACKEND HOOK (later)
              debugPrint('Selected filter: $filter');
            },
            child: Container(
              height: 31,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: isSelected
                    ? Border.all(color: AppColors.primary, width: 1)
                    : null,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// ICON (optional)
                  if (filter == 'Filter')
                    const Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.tune,
                        size: 16,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),

                  Text(
                    filter,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? AppColors.primary
                          : const Color(0xFF2D2D2D),
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
