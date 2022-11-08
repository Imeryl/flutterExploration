import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  final String? authToken;

  Orders(this.authToken, this._orders);

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> products, double total) {
    final url = Uri.parse(
        'https://flutter-udemy-cead0-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=$authToken');
    final timestamp = DateTime.now();
    return http
        .post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': products
            .map((item) => {
                  'id': item.id,
                  'price': item.price,
                  'productId': item.productId,
                  'quantity': item.quantity,
                })
            .toList(),
      }),
    )
        .then((response) {
      _orders.add(
        Order(
          amount: total,
          dateTime: timestamp,
          id: json.decode(response.body)['name'],
          products: products,
        ),
      );
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
  }

  Future<void> fetchOrders() {
    final url = Uri.parse(
        'https://flutter-udemy-cead0-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=$authToken');

    return http.get(url).then(
      (response) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        _orders = [];
        data.forEach((orderId, orderData) {
          _orders.add(Order(
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            id: orderId,
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                      id: item['id'],
                      price: item['price'],
                      productId: item['productId'],
                      quantity: item['quantity'],
                    ))
                .toList(),
          ));
        });
        notifyListeners();
      },
    );
  }
}
