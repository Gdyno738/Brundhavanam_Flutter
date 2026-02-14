// enum OrderStatus {
//   active,
//   completed,
//   cancelled,
// }
//
// enum RefundStatus {
//   none,
//   initiated,
//   completed,
// }
//
// class OrderModel {
//   final String title;
//   final String subtitle;
//   final String price;
//   final String address;
//   final DateTime orderDate;
//   final String image;
//
//   OrderStatus status;
//   RefundStatus refundStatus;
//
//   OrderModel({
//     required this.title,
//     required this.subtitle,
//     required this.price,
//     required this.address,
//     required this.orderDate,
//     required this.image,
//     this.status = OrderStatus.active,
//     this.refundStatus = RefundStatus.none,
//   });
//
//   bool get completed => status == OrderStatus.completed;
//   bool get cancelled => status == OrderStatus.cancelled;
// }


import 'billing_details.dart';
import 'order_item.dart';


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
  final String orderId;
  final List<OrderItem> items;
  final String address;
  final DateTime orderDate;
  final BillingDetails billing; // ✅ NEW

  OrderStatus status;
  RefundStatus refundStatus;

  OrderModel({
    required this.orderId,
    required this.items,
    required this.address,
    required this.orderDate,
    required this.billing, // ✅ REQUIRED
    this.status = OrderStatus.active,
    this.refundStatus = RefundStatus.none,
  });

  bool get completed => status == OrderStatus.completed;
  bool get cancelled => status == OrderStatus.cancelled;
}



