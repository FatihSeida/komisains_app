import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProfileProvider with ChangeNotifier {
  CakabaProfile items;
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

  ProfileProvider({this.authToken, this.userId});

  CakabaProfile get getData {
    return items;
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

      final loaded = CakabaProfile.fromMap(extractedData['cakaba-profile']);

      items = loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}

class KomProfile {
  KomProfile({
    @required this.cakabaProfile,
    @required this.message,
  });

  final CakabaProfile cakabaProfile;
  final String message;

  factory KomProfile.fromJson(String str) =>
      KomProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KomProfile.fromMap(Map<String, dynamic> json) => KomProfile(
        cakabaProfile: CakabaProfile.fromMap(json["cakaba-profile"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "cakaba-profile": cakabaProfile.toMap(),
        "message": message,
      };
}

class CakabaProfile with ChangeNotifier {
  CakabaProfile({
    @required this.id,
    @required this.description,
    @required this.thumbnail,
    @required this.createdAt,
    @required this.updatedAt,
  });

  final int id;
  final String description;
  final String thumbnail;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory CakabaProfile.fromJson(String str) =>
      CakabaProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CakabaProfile.fromMap(Map<String, dynamic> json) => CakabaProfile(
        id: json["id"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "description": description,
        "thumbnail": thumbnail,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
