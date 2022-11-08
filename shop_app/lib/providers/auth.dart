import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/httpexception.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  String? get userId {
    return _userId;
  }

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }

    return null;
  }

  Future<void> _authenticateUser(
      String email, String password, String endpoint) async {
    final uri = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:${endpoint}?key=AIzaSyAVHfcW-07vTrleHQ6WWZl7Oy7DG5nVfOc');
    try {
      final response = await http.post(
        uri,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) {
    return _authenticateUser(email, password, 'signInWithPassword');
  }

  void logout() {
    _expiryDate = null;
    _token = null;
    _userId = null;
    notifyListeners();
  }

  Future<void> signup(String email, String password) {
    return _authenticateUser(email, password, 'signUp');
  }
}
