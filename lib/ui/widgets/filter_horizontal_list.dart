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

  IconData _getIcon(String filter) {
    switch (filter) {
      case 'Filter':
        return Icons.tune;
      case '500 ml':
        return Icons.local_drink;
      case '20% off':
      case '50% off':
        return Icons.percent;
      case 'Combo':
        return Icons.layers;
      case '2 Liter':
        return Icons.water_drop;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final bool isSelected = filter == selectedFilter;

          return GestureDetector(
            onTap: () {
              setState(() => selectedFilter = filter);
              debugPrint('Selected filter: $filter');
            },
            child: Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),

                /// 🔹 subtle selected feedback (same look)
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(
                      alpha: isSelected ? 0.18 : 0.15,
                    ),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getIcon(filter),
                    size: 16,
                    color: const Color(0xFF2D2D2D),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    filter,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D2D2D),
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
