import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Structures with ChangeNotifier {
  Structures({
    required this.structures,
    required this.message,
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
    required this.id,
    required this.name,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    required this.thumbnail,
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
        thumbnail:
            'https://komdakkomcakaba.my.id/pengurus-thumbnail/${json["thumbnail"]}',
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
