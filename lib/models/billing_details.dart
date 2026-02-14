class BillingDetails {
  final double subTotal;
  final double discount;
  final double deliveryCharge;
  final double tax;
  final double totalAmount;

  const BillingDetails({
    required this.subTotal,
    required this.discount,
    required this.deliveryCharge,
    required this.tax,
    required this.totalAmount,
  });
}
