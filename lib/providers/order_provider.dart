import 'package:flutter/material.dart';
import '../screens/orders/order_status.dart';
import '../screens/orders/orders_model.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  void setOrders(List<OrderModel> orders) {
    _orders
      ..clear()
      ..addAll(orders);
    notifyListeners();
  }

  void cancelOrder(OrderModel order) {
    order.status = OrderStatus.cancelled;
    notifyListeners();
  }

  void initiateRefund(OrderModel order) {
    order.refundStatus = RefundStatus.initiated;
    notifyListeners();
  }

  void completeRefund(OrderModel order) {
    order.refundStatus = RefundStatus.completed;
    notifyListeners();
  }
}
