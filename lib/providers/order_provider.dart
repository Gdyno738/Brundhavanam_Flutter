import 'package:flutter/material.dart';
import '../models/orders_model.dart';
import '../services/order_service.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _orderService = OrderService();

  final List<OrderModel> _orders = [];

  bool _isLoading = false;
  String? _error;

  List<OrderModel> get orders => List.unmodifiable(_orders);
  bool get isLoading => _isLoading;
  String? get error => _error;

  // ================= FETCH ORDERS =================

  Future<void> fetchOrders() async {
    try {
      _isLoading = true;
      notifyListeners();

      final fetchedOrders = await _orderService.fetchOrders();

      _orders
        ..clear()
        ..addAll(fetchedOrders);

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ================= CREATE ORDER =================

  Future<void> addOrder(OrderModel order) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _orderService.createOrder(order);

      _orders.insert(0, order); // newest first
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ================= CANCEL ORDER =================

  Future<void> cancelOrder(String orderId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _orderService.cancelOrder(orderId);

      final order =
      _orders.firstWhere((o) => o.orderId == orderId);

      order.status = OrderStatus.cancelled;

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ================= REFUND =================

  Future<void> initiateRefund(String orderId) async {
    try {
      await _orderService.initiateRefund(orderId);

      final order =
      _orders.firstWhere((o) => o.orderId == orderId);

      order.refundStatus = RefundStatus.initiated;

      notifyListeners();
    } catch (_) {}
  }

  Future<void> completeRefund(String orderId) async {
    try {
      await _orderService.completeRefund(orderId);

      final order =
      _orders.firstWhere((o) => o.orderId == orderId);

      order.refundStatus = RefundStatus.completed;

      notifyListeners();
    } catch (_) {}
  }
}
