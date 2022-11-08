import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/httpexception.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token = '';
  DateTime? _expiryDate;
  String userId = '';

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
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) {
    return _authenticateUser(email, password, 'signInWithPassword');
  }

  Future<void> signup(String email, String password) {
    return _authenticateUser(email, password, 'signUp');
  }
}
