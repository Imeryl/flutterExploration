import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [];
  final String? authToken;
  final String? userId;

  Products(this.authToken, this._products, this.userId);

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
        'https://flutter-udemy-cead0-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken');
    return http
        .post(
      url,
      body: json.encode({
        'description': product.description,
        'imageUrl': product.imageUrl,
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

  Future<void> deleteProduct(String id) {
    final url = Uri.parse(
        'https://flutter-udemy-cead0-default-rtdb.europe-west1.firebasedatabase.app/products/${id}.json?auth=$authToken');
    return http.delete(url).then((value) {
      _products.removeWhere((product) => product.id == id);
      notifyListeners();
    });
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse(
        'https://flutter-udemy-cead0-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken');

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      final favouriteResponse = await http.get(Uri.parse(
          'https://flutter-udemy-cead0-default-rtdb.europe-west1.firebasedatabase.app/userFavourites/$userId.json?auth=$authToken'));
      final favouriteData = json.decode(favouriteResponse.body);
      final List<Product> _products = [];
      responseData.forEach((productId, productData) {
        _products.add(Product(
          description: productData['description'],
          id: productId,
          imageUrl: productData['imageUrl'],
          isFavourite: favouriteData[productId] ?? false,
          name: productData['name'],
          price: productData['price'],
        ));
      });
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> toggleFavourite(String id) {
    var product = findById(id);
    product.toggleFavourite();
    final url = Uri.parse(
        'https://flutter-udemy-cead0-default-rtdb.europe-west1.firebasedatabase.app/userFavourites/$userId/${id}.json?auth=$authToken');
    return http
        .put(
      url,
      body: json.encode(product.isFavourite),
    )
        .catchError((error) {
      product.toggleFavourite();
      throw error;
    });
  }

  Future<void> updateProduct(String id, Product product) {
    final url = Uri.parse(
        'https://flutter-udemy-cead0-default-rtdb.europe-west1.firebasedatabase.app/products/${id}.json?auth=$authToken');
    return http
        .patch(
      url,
      body: json.encode({
        'description': product.description,
        'imageUrl': product.imageUrl,
        'isFavourite': product.isFavourite,
        'name': product.name,
        'price': product.price,
      }),
    )
        .then((value) {
      final prodIndex = _products.indexWhere((product) => product.id == id);
      _products[prodIndex] = product;
      notifyListeners();
    });
  }
}
