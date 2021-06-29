import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Books {
  Books({
    required this.ebook,
    required this.message,
  });

  final List<Book> ebook;
  final String message;

  factory Books.fromJson(String str) => Books.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Books.fromMap(Map<String, dynamic> json) => Books(
        ebook: List<Book>.from(json["ebook"].map((x) => Book.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "ebook": List<dynamic>.from(ebook.map((x) => x.toMap())),
        "message": message,
      };
}

class Book with ChangeNotifier {
  Book({
    required this.id,
    required this.name,
    required this.by,
    required this.file,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.thumbnail,
  });

  final int id;
  final String name;
  final String by;
  final String file;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic thumbnail;

  factory Book.fromJson(String str) => Book.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Book.fromMap(Map<String, dynamic> json) => Book(
        id: json["id"],
        name: json["name"],
        by: json["by"],
        file: 'https://komdakkomcakaba.my.id/ebooks/${json["file"]}',
        category: json["category"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        thumbnail: 'https://komdakkomcakaba.my.id/ebooks-thumbnail/${json["thumbnail"]}',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "by": by,
        "file": file,
        "category": category,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "thumbnail": thumbnail,
      };
}
