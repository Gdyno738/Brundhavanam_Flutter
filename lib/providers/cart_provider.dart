import 'package:flutter/material.dart';
import '../models/product.dart';

class CowCartItem {
  final String name;
  final String image;
  final double price;

  CowCartItem({
    required this.name,
    required this.image,
    required this.price,
  });
}

class CartProvider extends ChangeNotifier {
  final Map<Product, int> _items = {};

  CowCartItem? _cowItem;

  Map<Product, int> get items => _items;

  CowCartItem? get cowItem => _cowItem;

  /// ---------------- PRODUCT METHODS ----------------

  void addToCart(Product product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + 1;
    } else {
      _items[product] = 1;
    }
    notifyListeners();
  }

  void increase(Product product) {
    _items[product] = _items[product]! + 1;
    notifyListeners();
  }

  void decrease(Product product) {
    if (_items[product]! > 1) {
      _items[product] = _items[product]! - 1;
    } else {
      _items.remove(product);
    }
    notifyListeners();
  }

  bool isInCart(Product product) => _items.containsKey(product);

  int quantity(Product product) => _items[product] ?? 0;

  /// ---------------- COW METHODS ----------------

  void addCowToCart(String name, String image, double price) {
    _cowItem = CowCartItem(
      name: name,
      image: image,
      price: price,
    );
    notifyListeners();
  }

  void removeCowFromCart() {
    _cowItem = null;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }


  /// ---------------- TOTAL ----------------

  double get totalAmount {
    double total = 0;

    _items.forEach((product, qty) {
      total += product.price * qty;
    });

    if (_cowItem != null) {
      total += _cowItem!.price;
    }

    return total;
  }
}
