import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:komisains_app/modules/user_profile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAuthRepository {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;
  UserClass? _items;

  UserClass? get items {
    return _items;
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

  Future<bool> login(String email, String password) async {
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
      return token != null;
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
