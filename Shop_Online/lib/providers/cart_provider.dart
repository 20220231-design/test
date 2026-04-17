import 'package:flutter/material.dart';

import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  int get itemCount => _cartItems.length;

  double get totalPrice {
    double total = 0;

    for (var item in _cartItems) {
      total += item.price;
    }

    return total;
  }

  void addToCart(ProductModel product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  bool isInCart(ProductModel product) {
    return _cartItems.contains(product);
  }
}