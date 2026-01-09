import 'package:flutter/material.dart';
import '../../home/sections/location_header.dart';

class DonationForm15Screen extends StatelessWidget {
  const DonationForm15Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          /// ✅ USE LOCATION HEADER DIRECTLY
          const SafeArea(
            bottom: false,
            child: LocationHeader(
              title: 'Donations',
              subtitle: 'Indira Nagar, Gachibowli, Hyderabad',
              showBack: true,
              showDropdown: false,
            ),
          ),

          /// BODY
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// FORM 15 BOX
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFCACACA)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Form 15',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF565656),
                          ),
                        ),
                        Icon(Icons.download, size: 20),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ORDER SUMMARY
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Order summary',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Donated On 28 Dec 2025, 5:00AM',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _row(
                    leftTitle: 'Donation Id',
                    leftValue: '#7569229657',
                    rightTitle: 'Date',
                    rightValue: '1/1/2026',
                  ),
                  _row(
                    leftTitle: 'Person Name',
                    leftValue: 'Tony Stark',
                    rightTitle: 'Contact Number',
                    rightValue: '1234567890',
                  ),
                  _row(
                    leftTitle: 'Donated Amount',
                    leftValue: '1000',
                    rightTitle: 'No of Donations',
                    rightValue: '02',
                  ),
                  _row(
                    leftTitle: 'Donated For',
                    leftValue:
                    'Donate for Green grass - Rs 1,000 per Load',
                    rightTitle: 'Transaction Id',
                    rightValue: '1234567890',
                  ),
                  _row(
                    leftTitle: 'Payment Method',
                    leftValue: 'UPI Payment',
                    rightTitle: 'Person Address',
                    rightValue:
                    'Gachibowli, Hyderabad\nSector 1, PSR Prime Towers\n500076',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


  Widget _row({
    required String leftTitle,
    required String leftValue,
    String? rightTitle,
    String? rightValue,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _info(leftTitle, leftValue)),
          if (rightTitle != null && rightValue != null) ...[
            const SizedBox(width: 20),
            Expanded(child: _info(rightTitle, rightValue)),
          ],
        ],
      ),
    );
  }

  Widget _info(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }



