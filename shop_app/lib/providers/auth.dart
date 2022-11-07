import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/httpexception.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token = '';
  DateTime? _expiryDate;
  String userId = '';

  Future<void> login(String email, String password) {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAVHfcW-07vTrleHQ6WWZl7Oy7DG5nVfOc');
    return http
        .post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    )
        .then((response) {
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    }).catchError((error) {});
  }

  Future<void> signup(String email, String password) {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAVHfcW-07vTrleHQ6WWZl7Oy7DG5nVfOc');
    return http
        .post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    )
        .then((response) {
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    }).catchError((error) {});
  }
}
