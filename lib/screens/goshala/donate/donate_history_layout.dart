import 'package:flutter/material.dart';
import '../../../ui/common/app_colors.dart';

class DonateHistoryLayout extends StatelessWidget {
  const DonateHistoryLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 7, // placeholder count
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return _historyItem();
      },
    );
  }

  Widget _historyItem() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// LEFT SIDE
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE PLACEHOLDER
              Container(
                width: 47,
                height: 47,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 10),

              /// TEXT
              SizedBox(
                width: 190,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Donated for Green grass',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '19/12/2025',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// AMOUNT
          const Text(
            '₹ 1000/-',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
