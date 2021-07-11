import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:komisains_app/modules/news/models/news.dart';

class NewsRepository {
  final String? authToken;
  final String? userId;

  NewsRepository({this.authToken, this.userId});

  Future<List<Article>> fetchData() async {
    try {
      final response = await http.get(
          Uri.parse('https://api.komdakkomcakaba.my.id/api/articles'),
          headers: {
            'Content-type': 'application/json',
            'Accept': '/',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
            'Authorization': 'Bearer $authToken',
          });

      final extractedData = json.decode(response.body.toString());
      final List<Article> loaded = [];
      for (Map<String, dynamic> i in extractedData["articles"]) {
        loaded.add(Article.fromMap(i));
      }
      return loaded;
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
