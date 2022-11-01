import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String productId;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.price,
    required this.productId,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.00;
    _items.forEach(
        (key, cartItem) => total += cartItem.price * cartItem.quantity);

    return total;
  }

  void addItem(String productId, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          price: existingItem.price,
          productId: existingItem.productId,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          productId: productId,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((key, item) => item.id == id);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]?.quantity as int > 1) {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          price: existingItem.price,
          productId: existingItem.productId,
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      _items.removeWhere((key, item) => item.productId == productId);
    }

    notifyListeners();
  }
}
