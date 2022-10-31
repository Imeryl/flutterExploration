import 'package:flutter/material.dart';

import 'cart.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  Order({
    required this.amount,
    required this.dateTime,
    required this.id,
    required this.products,
  });
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> products, double total) {
    _orders.insert(
      0,
      Order(
        amount: total,
        dateTime: DateTime.now(),
        id: DateTime.now().toString(),
        products: products,
      ),
    );
    notifyListeners();
  }
}
