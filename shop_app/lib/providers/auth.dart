import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/httpexception.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  Timer? _authTimer;
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
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': userId,
        'expiryDate': _expiryDate?.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  void _autoLogout() {
    if (_authTimer != null) _authTimer?.cancel();
    final timeToexpiry = _expiryDate?.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToexpiry ?? 0), logout);
  }

  Future<void> login(String email, String password) {
    return _authenticateUser(email, password, 'signInWithPassword');
  }

  Future<void> logout() async {
    _expiryDate = null;
    _token = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  Future<void> signup(String email, String password) {
    return _authenticateUser(email, password, 'signUp');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) return false;

    final userData =
        json.decode(prefs.getString('userData') ?? '') as Map<String, dynamic>;
    final expiryDate = DateTime.parse(userData['expiryDate'] as String);

    if (expiryDate.isAfter(DateTime.now())) return false;

    _expiryDate = expiryDate;
    _token = userData['token'] as String;
    _userId = userData['userId'] as String;
    notifyListeners();
    _autoLogout();

    return true;
  }
}
