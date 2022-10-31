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
    return {...items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String productId, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => CartItem(
            id: existingItem.id,
            price: existingItem.price,
            productId: existingItem.productId,
            quantity: existingItem.quantity + 1),
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
}
