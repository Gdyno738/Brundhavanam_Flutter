import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/common/base_screen.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(

      statusBarColor: AppColors.white,
      statusBarIconBrightness: Brightness.dark,
      child: Column(
        children: [

          /// 🔹 HEADER
          SafeArea(
            bottom: false,
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE7E7E7)),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back,
                        color: AppColors.black),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Your Orders',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🔹 BODY
          Expanded(
            child: Column(
              children: [

                /// 🗺 MAP SECTION
                SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/map_placeholder.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      CustomPaint(
                        size: Size.infinite,
                        painter: _RoutePainter(),
                      ),
                      const Positioned(
                        top: 60,
                        left: 120,
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 34,
                        ),
                      ),
                      const Positioned(
                        bottom: 70,
                        right: 120,
                        child: Icon(
                          Icons.delivery_dining,
                          color: AppColors.primary,
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                ),

                /// ⏱ ETA
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFE7E7E7)),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Estimated arrival at 7:00 AM',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '⏱ On the way',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      Text(
                        '📞 Call Driver\n1234567890',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                /// 📦 ORDER STATUS
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _statusRow(
                        label: 'Order Placed',
                        value: '23 Dec 2025',
                      ),
                      const SizedBox(height: 12),
                      _statusRow(
                        label: 'OTP',
                        value: '1234',
                        highlight: true,
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                /// 📄 ORDER DETAILS
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12),
                      DetailField('Sriya'),
                      SizedBox(height: 8),
                      DetailField('1234567890'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  /// STATUS ROW
  Widget _statusRow({
    required String label,
    required String value,
    bool highlight = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: highlight ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: highlight ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

/// 🗺 ROUTE LINE PAINTER
class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    final path = Path()
      ..moveTo(size.width * 0.35, size.height * 0.3)
      ..lineTo(size.width * 0.55, size.height * 0.6)
      ..lineTo(size.width * 0.65, size.height * 0.75);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// ORDER DETAIL FIELD
class DetailField extends StatelessWidget {
  final String text;
  const DetailField(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7E7E7)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
