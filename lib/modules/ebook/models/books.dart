import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BooksProvider with ChangeNotifier {
  List<Book> _items = [];

  final String? authToken;
  final String? userId;
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

  BooksProvider(this.authToken, this.userId, this._items);

  List<Book> get items {
    return [..._items];
  }

  List<Book> get materiWajib {
    return _items
        .where((booksItem) => booksItem.category == 'Materi Wajib')
        .toList();
  }

  List<Book> get resensiBuku {
    return _items
        .where((booksItem) => booksItem.category == 'Resensi')
        .toList();
  }

  Future<void> getPickup() async {
    

    try {
      final response = await http.get(Uri.parse('https://api.komdakkomcakaba.my.id/api/articles'), headers: {
        'Content-type': 'application/json',
        'Accept': '/',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Authorization': 'Bearer $authToken'
      });

      final extractedData = json.decode(response.body.toString());
      final List<Book> loaded = [];
      for (Map<String, dynamic> i in extractedData['ebook']) {
        loaded.add(Book.fromMap(i));
      }
      _items = loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}

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
