enum OrderStatus {
  active,
  completed,
  cancelled,
  success, // ✅ REQUIRED by OrderPlacedScreen
}

enum RefundStatus {
  none,
  initiated,
  completed,
}

class OrderModel {
  final String title;
  final String subtitle;
  final String price;
  final String address;
  final DateTime orderDate;

  OrderStatus status;          // ✅ mutable
  RefundStatus refundStatus;   // ✅ exists

  final String? image;

  OrderModel({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.address,
    required this.orderDate,
    required this.status,
    this.refundStatus = RefundStatus.none,
    this.image,
  });

  bool get completed =>
      status == OrderStatus.completed || status == OrderStatus.success;

  bool get cancelled => status == OrderStatus.cancelled;
}
