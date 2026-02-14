import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class FilterHorizontalList extends StatefulWidget {
  const FilterHorizontalList({super.key});

  @override
  State<FilterHorizontalList> createState() =>
      _FilterHorizontalListState();
}

class _FilterHorizontalListState
    extends State<FilterHorizontalList> {

  String? selectedFilter; // ✅ nothing selected initially

  final List<String> filters = [
    'Filter',
    '500 ml',
    '20% off',
    'Combo',
    '50% off',
    '2 Litr',
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
      case '2 Litr':
        return Icons.water_drop;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(
          left: 16,
          right: 40,
          top: 8,
          bottom: 8,
        ),
        itemCount: filters.length,
        separatorBuilder: (_, __) =>
        const SizedBox(width: 12),
        itemBuilder: (_, index) {
          final filter = filters[index];
          final bool isActive = filter == selectedFilter;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = filter;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 93,
              height: 31,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary
                    : Colors.white,
                borderRadius:
                BorderRadius.circular(25), // ✅ fully rounded
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Icon(
                    _getIcon(filter),
                    size: 16,
                    color: isActive
                        ? Colors.white
                        : const Color(0xFF2D2D2D),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    filter,
                    style: TextStyle(
                      color: isActive
                          ? Colors.white
                          : const Color(0xFF2D2D2D),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
