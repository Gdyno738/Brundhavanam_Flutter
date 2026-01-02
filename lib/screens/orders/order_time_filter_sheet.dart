import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import 'order_time_filter.dart';

class OrderTimeFilterSheet extends StatefulWidget {
  final OrderTimeFilter selected;

  const OrderTimeFilterSheet({super.key, required this.selected});

  @override
  State<OrderTimeFilterSheet> createState() => _OrderTimeFilterSheetState();
}

class _OrderTimeFilterSheetState extends State<OrderTimeFilterSheet> {
  late OrderTimeFilter _current;

  @override
  void initState() {
    super.initState();
    _current = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 385,
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 50,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _item(OrderTimeFilter.lastWeek, 'Last week'),
            _item(OrderTimeFilter.pastThreeMonths, 'Past 3 months'),
            _item(OrderTimeFilter.thisYear,'This year'),
            _item(OrderTimeFilter.lastYear, 'last year'),
          ],
        ),
      ),
    );
  }

  Widget _item(OrderTimeFilter value, String label) {
    final selected = _current == value;

    return InkWell(
      onTap: () => Navigator.pop(context, value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.lightGrey),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 23,
              height: 23,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primary),
              ),
              child: selected
                  ? const DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              )
                  : const SizedBox(),
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
