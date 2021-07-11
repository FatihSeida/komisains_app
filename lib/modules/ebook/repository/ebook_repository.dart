import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:komisains_app/modules/ebook/models/books.dart';

class EbookRepository {
  final String? userId;
  final String? authToken;

  EbookRepository({
    this.userId,
    this.authToken,
  });

  Future<List<Book>> fetchData(String authToken) async {
    try {
      final response = await http.get(
          Uri.parse('https://api.komdakkomcakaba.my.id/api/ebooks'),
          headers: {
            'Content-type': 'application/json',
            'Accept': '/',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
            'Authorization': 'Bearer $authToken',
          });

      final extractedData = json.decode(response.body.toString());
      final List<Book> loaded = [];
      for (Map<String, dynamic> i in extractedData["ebook"]) {
        loaded.add(Book.fromMap(i));
      }
      return loaded;
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
