import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NewsProvider with ChangeNotifier {
  List<Article> items = [];
  bool isLoading = true;

  final String authToken;
  final String userId;
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

  NewsProvider(this.authToken, this.userId, this.items);

  List<Article> get getData {
    return [...items];
  }

  Future<void> getPickup() async {
    try {
      final response = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': '/',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      });

      final extractedData = json.decode(response.body.toString());
      final List<Article> loaded = [];
      for (Map i in extractedData['articles']) {
        loaded.add(Article.fromMap(i));
      }
      items = loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}

class News with ChangeNotifier {
  News({
    this.articles,
    this.message,
  });

  List<Article> articles;
  String message;

  factory News.fromJson(String str) => News.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory News.fromMap(Map<String, dynamic> json) => News(
        articles:
            List<Article>.from(json["articles"].map((x) => Article.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "articles": List<dynamic>.from(articles.map((x) => x.toMap())),
        "message": message,
      };
}

class Article with ChangeNotifier {
  Article({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.thumbnail,
    @required this.by,
    @required this.tag,
    @required this.createdAt,
    @required this.updatedAt,
  });

  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final String by;
  final String tag;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Article.fromJson(String str) => Article.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Article.fromMap(Map<String, dynamic> json) => Article(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        by: json["by"],
        tag: json["tag"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "thumbnail": thumbnail,
        "by": by,
        "tag": tag,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
