import '../models/billing_details.dart';
import '../models/orders_model.dart';
import '../models/order_item.dart';


class OrderService {

  /// 🔹 Fetch Orders (Future API)
  Future<List<OrderModel>> fetchOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));

    // TODO: Replace with real API call
    return [];
  }

  /// 🔹 Create Order (Future API)
  Future<void> createOrder(OrderModel order) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // TODO: POST /orders
  }

  Future<void> cancelOrder(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> initiateRefund(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> completeRefund(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // ============================================================
  // ✅ CENTRAL BILLING ENGINE (THIS IS THE IMPORTANT PART)
  // ============================================================

  BillingDetails calculateBilling(
      List<OrderItem> items, {
        double adminDiscountPercent = 0,   // 🔹 dynamic from backend later
        double cowDeliveryCharge = 100,
        double productDeliveryCharge = 50,
      }) {

    double subTotal = 0;

    for (var item in items) {
      final numericPrice =
          double.tryParse(item.price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;

      subTotal += numericPrice * item.quantity;
    }

    final bool isCowOrder =
        items.length == 1 && items.first.subtitle == "Cow Booking";

    double deliveryCharge = isCowOrder
        ? cowDeliveryCharge
        : productDeliveryCharge;

    double discount = 0;

    if (!isCowOrder && adminDiscountPercent > 0) {
      discount = subTotal * (adminDiscountPercent / 100);
    }

    final totalAmount = subTotal - discount + deliveryCharge;

    return BillingDetails(
      subTotal: subTotal,
      discount: discount,
      deliveryCharge: deliveryCharge,
      tax: 0,
      totalAmount: totalAmount,
    );
  }
}
