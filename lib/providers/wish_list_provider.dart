import 'package:flutter/material.dart';
import '../models/product.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  bool isWishlisted(Product product) {
    return _items.any((p) => p.title == product.title);
  }

  void toggle(Product product) {
    if (isWishlisted(product)) {
      _items.removeWhere((p) => p.title == product.title);
    } else {
      _items.add(product);
    }
    notifyListeners();
  }
}
