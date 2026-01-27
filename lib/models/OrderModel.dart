enum OrderStatus {
  active,
  outForDelivery,
  completed,
  cancelled,
}

class OrderModel {
  final String title;
  final String subtitle;
  final String price;
  final String address;
  final DateTime orderDate;
  final OrderStatus status;
  final String image;

  OrderModel({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.address,
    required this.orderDate,
    required this.status,
    required this.image,
  });
}
