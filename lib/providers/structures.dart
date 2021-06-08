import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class StructureProvider with ChangeNotifier {
  List<Structure> items = [];
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

  StructureProvider({this.authToken, this.userId});

  List<Structure> get getData {
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
      final List<Structure> loaded = [];
      for (Map i in extractedData['structures']) {
        loaded.add(Structure.fromMap(i));
      }
      items = loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}

class Structures with ChangeNotifier {
  Structures({
    @required this.structures,
    @required this.message,
  });

  final List<Structure> structures;
  final String message;

  factory Structures.fromJson(String str) =>
      Structures.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Structures.fromMap(Map<String, dynamic> json) => Structures(
        structures: List<Structure>.from(
            json["structures"].map((x) => Structure.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "structures": List<dynamic>.from(structures.map((x) => x.toMap())),
        "message": message,
      };
}

class Structure with ChangeNotifier {
  Structure({
    @required this.id,
    @required this.name,
    @required this.position,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.thumbnail,
  });

  final int id;
  final String name;
  final String position;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String thumbnail;

  factory Structure.fromJson(String str) => Structure.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Structure.fromMap(Map<String, dynamic> json) => Structure(
        id: json["id"],
        name: json["name"],
        position: json["position"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "position": position,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "thumbnail": thumbnail,
      };
}
