import 'package:flutter/material.dart';
import '../../../ui/common/app_colors.dart';
import '../../goshala/donate/DonationForm15Screen.dart';


class DonateHistoryLayout extends StatelessWidget {
  const DonateHistoryLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: 7, // placeholder
      separatorBuilder: (_, __) => Divider(
        color: AppColors.grey,
        thickness: 0,
        height: 20,
      ),
      itemBuilder: (context, index) => _historyItem(context),
    );
  }

  Widget _historyItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// LEFT SECTION
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            Container(
              width: 47,
              height: 47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.lightGrey,
                image: const DecorationImage(
                  image: NetworkImage('https://placehold.co/47x47'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 10),

            /// TEXT (CLICKABLE)
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DonationForm15Screen(),
                  ),
                );
              },
              child: SizedBox(
                width: 188,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Donated for Green grass',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '19/12/2025',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
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
    );
  }

}
