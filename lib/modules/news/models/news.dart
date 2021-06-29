import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class News with ChangeNotifier {
  News({
    required this.articles,
    required this.message,
  });

  final List<Article> articles;
  final String message;

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
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.by,
    required this.tag,
    required this.createdAt,
    required this.updatedAt,
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
        thumbnail:
            'https://komdakkomcakaba.my.id/articlephotos/${json["thumbnail"]}',
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
