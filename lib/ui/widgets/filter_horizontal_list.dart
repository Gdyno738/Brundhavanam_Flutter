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
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (_, index) {
          final filter = filters[index];
          final bool isActive = filter == selectedFilter;

          return GestureDetector(
            onTap: () {
              setState(() => selectedFilter = filter);
            },
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(25),
                border: isActive
                    ? null
                    : Border.all(
                  color: AppColors.grey,
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getIcon(filter),
                    size: 16,
                    color: isActive
                        ? AppColors.white
                        : AppColors.black,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    filter,
                    style: TextStyle(
                      color: isActive
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1,
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
