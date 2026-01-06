class OrderModel {
  final String title;
  final String subtitle;
  final String price;
  final String buttonText;
  final DateTime orderDate;
  final String address;
  final bool completed;

  OrderModel({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.buttonText,
    required this.orderDate,
    required this.address,
    this.completed = false,
  });
}
