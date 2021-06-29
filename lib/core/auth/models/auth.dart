import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:komisains_app/models/http_exection.dart';
import 'package:komisains_app/modules/user_profile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;
  UserClass? _items;
  var _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  UserClass? get items {
    return _items;
  }

  String? get isAuth {
    return token;
  }

  String? get token {
    if (_expiryDate != null && _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> signup(Map<String, String> profile) async {
    try {
      final response =
          await http.post(Uri.parse('https://api.komdakkomcakaba.my.id/api/register'),
              body:
                  // json.encode(profile),
                  json.encode(
                {
                  'name': profile['name'],
                  'email': profile['email'],
                  'password': profile['password'],
                  'password_confirmation': profile['password_confirmation'],
                  'nohp': profile['nohp'],
                  'department': profile['department'],
                  'sex': profile['sex'],
                  'angkatan_kuliah': profile['angkatan_kuliah'],
                },
              ),
              headers: {
            'Content-type': 'application/json',
            'Accept': '/',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
          });
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String? email, String? password) async {
    try {
      final response = await http
          .post(Uri.parse('https://api.komdakkomcakaba.my.id/api/login'),
              body: json.encode(
                {
                  'email': email,
                  'password': password,
                  'returnSecureToken': true,
                },
              ),
              headers: {
            'Content-type': 'application/json',
            'Accept': '/',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
          });
      final responseData = json.decode(response.body.toString());
      final user = UserClass.fromMap(responseData['user']);
      _items = user;
      _token = responseData['access_token'];
      _userId = responseData['id'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: responseData['expires_in'],
        ),
      );
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate!.toIso8601String(),
          'user': user.toMap(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData').toString());
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    final user = UserClass.fromMap(extractedUserData['user']);
    _items = user;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData =
        json.decode(prefs.getString('userData').toString());
    final user = UserClass.fromMap(extractedUserData['user']);
    _items = user;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
