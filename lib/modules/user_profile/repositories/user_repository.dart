import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;
import 'package:komisains_app/models/http_exection.dart';
import 'package:komisains_app/modules/user_profile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  // final String? authToken;
  final String? userId;
  UserRepository({
    // this.authToken, 
    this.userId});

  Future<String> upload(File imageFile, String authToken) async {
    // open a bytestream
    var stream = new http.ByteStream(imageFile.openRead());
    stream.cast();
    // get file length
    var length = await imageFile.length();

    // string to uri

    var uri = Uri.parse('https://api.komdakkomcakaba.my.id/api/profile/photo');
    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('photo', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    //multipart that take headers
    Map<String, String> headers = {
      'Content-type': 'multipart/form-data',
      'Accept': '/',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      'Authorization': 'Bearer $authToken',
    };

    // add header to multipart
    request.headers.addAll(headers);
    request.fields['_method'] = 'PUT';

    // send
    http.Response response =
        await http.Response.fromStream(await request.send());
    print("Result: ${response.body}");
    final responseData = json.decode(response.body.toString());
    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }
    final prefs = await SharedPreferences.getInstance();
    final user = UserClass.fromMap(responseData['user']);
    final userData = json.encode(
      {
        'user': user.toMap(),
      },
    );
    prefs.setString('userData', userData);
    print(user);
    String message = responseData['message'];
    print('message');
    return message;
  }

  Future<String> editPassword(Map<String, String> password, String authToken) async {
    try {
      final response = await http.put(
        Uri.parse('https://api.komdakkomcakaba.my.id/api/profile/password'),
        headers: {
          'Content-type': 'application/json',
          'Accept': '/',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode({
          'old_password': password['old_password'],
          'new_password': password['new_password'],
          'confirm_password': password['confirm_password'],
          '_method': 'PUT',
        }),
      );
      final responseData = json.decode(response.body.toString());
      String message = responseData['message'];
      print('message');
      return message;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<UserClass> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData =
        json.decode(prefs.getString('userData').toString());
    final user = UserClass.fromMap(extractedUserData['user']);
    final _items = user;
    return _items;
  }

  Future<UserClass> getProfile() async {
    try {
      final response = await http.get(
          Uri.parse('https://api.komdakkomcakaba.my.id/api/profile'),
          headers: {
            'Content-type': 'application/json',
            'Accept': '/',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
          });
      final responseData = json.decode(response.body.toString());
      final user = UserClass.fromMap(responseData['user']);
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'user': user.toMap(),
        },
      );
      prefs.setString('userData', userData);
      return user;
    } catch (error) {
      throw error;
    }
  }

  Future<String> updateProfile(Map<String, String> newProduct, String authToken) async {
    try {
      final response = await http.put(
        Uri.parse('https://api.komdakkomcakaba.my.id/api/profile/edit'),
        headers: {
          'Content-type': 'application/json',
          'Accept': '/',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode({
          'id': newProduct['id'],
          'name': newProduct['name'],
          'address': newProduct['address'],
          'angkatan_kuliah': newProduct['angkatan_kuliah'],
          'department': newProduct['department'],
          'email': newProduct['email'],
          'hp': newProduct['nohp'],
          'sex': newProduct['sex'],
          'instagram': newProduct['instagram'],
          'jenjang_training': newProduct['jenjang_training'],
          'linkedin': newProduct['linkedin'],
          'other_social_media': newProduct['lainnya'],
          'pengalaman_organisasi': newProduct['pengalaman_organisasi'],
          'year_join': newProduct['year_join'],
          '_method': 'PUT',
        }),
      );
      final responseData = json.decode(response.body.toString());
      print(responseData['user']);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      final prefs = await SharedPreferences.getInstance();
      final user = UserClass.fromMap(responseData['user']);
      final userData = json.encode(
        {
          'user': user.toMap(),
        },
      );
      prefs.setString('userData', userData);
      print(user);
      String message = responseData['message'];
      print('message');
      return message;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
