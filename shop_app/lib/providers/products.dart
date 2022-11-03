import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get favouriteProducts {
    return _products.where((product) => product.isFavourite).toList();
  }

  List<Product> get products {
    return [..._products];
  }

  Product findById(String productId) {
    return _products.firstWhere((product) => product.id == productId);
  }

  Future<void> addProduct(Product product) {
    final url = Uri.parse(
        'https://flutter-udemy-cead0-default-rtdb.europe-west1.firebasedatabase.app/products.json');
    return http
        .post(
      url,
      body: json.encode({
        'description': product.description,
        'imageUrl': product.imageUrl,
        'isFavourite': product.isFavourite,
        'name': product.name,
        'price': product.price,
      }),
    )
        .then((response) {
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _products.add(newProduct);
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
  }

  void deleteProduct(String id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  Future<void> fetchProducts() {
    final url = Uri.parse(
        'https://flutter-udemy-cead0-default-rtdb.europe-west1.firebasedatabase.app/products.json');

    return http.get(url).then(
      (response) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        _products = [];
        data.forEach((productId, productData) {
          _products.add(Product(
            description: productData['description'],
            id: productId,
            imageUrl: productData['imageUrl'],
            isFavourite: productData['isFavourite'],
            name: productData['name'],
            price: productData['price'],
          ));
        });
        notifyListeners();
      },
    );
  }

  void updateProduct(String id, Product product) {
    final prodIndex = _products.indexWhere((product) => product.id == id);
    _products[prodIndex] = product;
    notifyListeners();
  }
}
