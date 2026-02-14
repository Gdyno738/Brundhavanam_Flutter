import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/common/base_screen.dart';
import '../../models/orders_model.dart';

class OrderTrackingScreen extends StatelessWidget {
  final OrderModel order;

  const OrderTrackingScreen({
    super.key,
    required this.order,
  });


  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      statusBarColor: AppColors.white,
      statusBarIconBrightness: Brightness.dark,
      child: Column(
        children: [

          /// 🔹 HEADER
          _buildHeader(context),

          /// 🔹 BODY
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🗺 MAP SECTION
                  _buildMapSection(),

                  const SizedBox(height: 16),

                  /// ⏱ ETA + CALL
                  _buildEtaSection(),

                  const SizedBox(height: 20),

                  /// 📦 ORDER DETAILS TITLE
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Order Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// 📦 ORDER INFO CARD
                  _buildOrderInfoCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(color: AppColors.lightGrey),
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
              "Your Orders",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= MAP =================

  Widget _buildMapSection() {
    return SizedBox(
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

          /// Route line
          CustomPaint(
            size: Size.infinite,
            painter: _RoutePainter(),
          ),

          /// Location pin
          const Positioned(
            top: 70,
            left: 100,
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 34,
            ),
          ),

          /// Delivery icon
          const Positioned(
            bottom: 60,
            right: 100,
            child: Icon(
              Icons.delivery_dining,
              color: AppColors.primary,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }

  // ================= ETA =================

  Widget _buildEtaSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Estimated arrival at 7:00 AM",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 6),

          Row(
            children: const [
              Icon(Icons.phone, size: 18, color: AppColors.black),
              SizedBox(width: 8),
              Text(
                "Call Driver",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 8),
              Text(
                "1234567890",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= ORDER INFO CARD =================

  Widget _buildOrderInfoCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        children: [

          /// Order placed
          _row(
            "Order Placed",
            "${order.orderDate.day} "
                "${_month(order.orderDate.month)} "
                "${order.orderDate.year}",
          ),


          const SizedBox(height: 12),

          /// OTP
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "OTP",
                style: TextStyle(fontSize: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "1234",
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const Divider(height: 30),

          /// Product Card
      Column(
        children: order.items.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.lightGrey),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: item.image.startsWith('http')
                      ? Image.network(
                    item.image,
                    width: 62,
                    height: 62,
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    item.image,
                    width: 62,
                    height: 62,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                      const SizedBox(height: 4),
                      Text(item.subtitle,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.grey,
                          )),
                      const SizedBox(height: 6),
                      Text(
                        "${item.price} x${item.quantity}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        Text(value, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

// ================= ROUTE LINE =================

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

String _month(int month) {
  const months = [
    "Jan","Feb","Mar","Apr","May","Jun",
    "Jul","Aug","Sep","Oct","Nov","Dec"
  ];
  return months[month - 1];
}
