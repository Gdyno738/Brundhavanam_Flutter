enum OrderStatus {
  active,
  completed,
  cancelled,
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
  final String image;

  OrderStatus status;
  RefundStatus refundStatus;

  OrderModel({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.address,
    required this.orderDate,
    required this.image,
    this.status = OrderStatus.active,
    this.refundStatus = RefundStatus.none,
  });

  bool get completed => status == OrderStatus.completed;
  bool get cancelled => status == OrderStatus.cancelled;
}
