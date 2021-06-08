import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class YTProvider with ChangeNotifier {
  List<Datum> items = [];
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

  YTProvider({this.authToken, this.userId});

  List<Datum> get getData {
    return [...items];
  }

  Future<void> getPickup() async {
    try {
      final response = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': '/',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Authorization': 'Bearer $authToken'
      });

      final extractedData = json.decode(response.body.toString());
      final List<Datum> loaded = [];
      for (Map i in extractedData['data']) {
        loaded.add(Datum.fromMap(i));
      }
      items = loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}

class ChannelYoutube {
  ChannelYoutube({
    @required this.data,
    @required this.message,
  });

  final List<Datum> data;
  final String message;

  factory ChannelYoutube.fromJson(String str) =>
      ChannelYoutube.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChannelYoutube.fromMap(Map<String, dynamic> json) => ChannelYoutube(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "message": message,
      };
}

class Datum with ChangeNotifier {
  Datum({
    @required this.id,
    @required this.title,
    @required this.thumbnail,
    @required this.url,
    @required this.createdAt,
    @required this.updatedAt,
  });

  final int id;
  final String title;
  final String thumbnail;
  final String url;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        url: json["url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "url": url,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
